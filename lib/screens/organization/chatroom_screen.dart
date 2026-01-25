import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'organizer_home.dart';
import 'organizer_profile_screen.dart';

class ChatroomScreen extends StatefulWidget {
  final String eventId;
  final String eventName;

  const ChatroomScreen({
    super.key,
    required this.eventId,
    required this.eventName,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _chatController = TextEditingController();
  final _announcementController = TextEditingController();

  String currentUserId = '';
  String currentUserName = '';
  bool isOrganizer = false;
  bool _loadingChat = false;
  bool _loadingAnnouncement = false;

  late TabController _tabController;
  final ScrollController _chatScrollController = ScrollController();
  final ScrollController _announcementScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initUser();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _initUser() async {
    final user = _auth.currentUser;
    if (user == null) return;

    currentUserId = user.uid;
    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final data = userDoc.data();
    setState(() {
      currentUserName = data?['name'] ?? 'You';
      isOrganizer = data?['role'] == 'organizer';
    });
  }

  // -------------------
  // CHAT MESSAGES
  // -------------------
  Future<void> sendMessage() async {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;

    setState(() => _loadingChat = true);
    try {
      await _firestore
          .collection('events')
          .doc(widget.eventId)
          .collection('messages')
          .add({
        'senderId': currentUserId,
        'senderName': currentUserName,
        'message': text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _chatController.clear();
      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _loadingChat = false);
    }
  }

  Widget _chatBubble(Map<String, dynamic> data, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF4F46E5) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(
                data['senderName'] ?? 'Unknown',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            const SizedBox(height: 2),
            Text(
              data['message'] ?? '',
              style: TextStyle(
                fontSize: 14,
                color: isMe ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------
  // ANNOUNCEMENTS
  // -------------------
  Future<void> sendAnnouncement() async {
    final text = _announcementController.text.trim();
    if (text.isEmpty) return;

    setState(() => _loadingAnnouncement = true);
    try {
      await _firestore
          .collection('events')
          .doc(widget.eventId)
          .collection('announcements')
          .add({
        'senderId': currentUserId,
        'senderName': currentUserName,
        'message': text,
        'createdAt': FieldValue.serverTimestamp(),
        'reactions': {}, // for likes
      });
      _announcementController.clear();
      _announcementScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _loadingAnnouncement = false);
    }
  }

  Widget _announcementBubble(Map<String, dynamic> data, String docId) {
    bool isMe = data['senderId'] == currentUserId;
    Map reactions = Map<String, dynamic>.from(data['reactions'] ?? {});

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Announcement by ${data['senderName'] ?? 'Organizer'}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        reactions.containsKey(currentUserId)
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        size: 18,
                      ),
                      onPressed: () {
                        // REACTION: toggle like
                        _firestore
                            .collection('events')
                            .doc(widget.eventId)
                            .collection('announcements')
                            .doc(docId)
                            .update({
                          'reactions.${currentUserId}':
                          reactions.containsKey(currentUserId) ? FieldValue.delete() : true,
                        });
                      },
                    ),
                    if (isMe)
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert, size: 18),
                        itemBuilder: (_) => [
                          const PopupMenuItem(value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditAnnouncementDialog(docId, data['message']);
                          } else if (value == 'delete') {
                            _firestore
                                .collection('events')
                                .doc(widget.eventId)
                                .collection('announcements')
                                .doc(docId)
                                .delete();
                          }
                        },
                      ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(data['message'] ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _announcementList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('events')
          .doc(widget.eventId)
          .collection('announcements')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final items = snapshot.data!.docs;
        if (items.isEmpty) return const Center(child: Text("No announcements yet"));

        return ListView.builder(
          controller: _announcementScrollController,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final data = items[index].data() as Map<String, dynamic>;
            final id = items[index].id;
            return _announcementBubble(data, id);
          },
        );
      },
    );
  }

  void _showAddAnnouncementDialog() {
    _announcementController.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Announcement"),
        content: TextField(
          controller: _announcementController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Type your announcement...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              sendAnnouncement();
              Navigator.pop(context);
            },
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }

  void _showEditAnnouncementDialog(String id, String oldMessage) {
    _announcementController.text = oldMessage;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Announcement"),
        content: TextField(
          controller: _announcementController,
          maxLines: 3,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              _firestore
                  .collection('events')
                  .doc(widget.eventId)
                  .collection('announcements')
                  .doc(id)
                  .update({'message': _announcementController.text.trim()});
              _announcementController.clear();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  Widget _chatList({required String collectionName, bool reverse = false, required ScrollController controller}) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('events')
          .doc(widget.eventId)
          .collection(collectionName)
          .orderBy('createdAt', descending: reverse)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final items = snapshot.data!.docs;
        if (items.isEmpty) return const Center(child: Text("No messages yet", style: TextStyle(color: Colors.grey)) );

        return ListView.builder(
          controller: controller,
          reverse: reverse,
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final data = items[index].data() as Map<String, dynamic>;
            final isMe = data['senderId'] == currentUserId;
            final isAnnouncement = collectionName == 'announcements';
            if (isAnnouncement) return _announcementBubble(data, items[index].id);
            return _chatBubble(data, isMe);
          },
        );
      },
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.eventName, style: const TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4F46E5),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4F46E5),
          tabs: const [
            Tab(text: "Chat"),
            Tab(text: "Announcements"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              Expanded(child: _chatList(collectionName: 'messages', reverse: false, controller: _chatScrollController)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _loadingChat
                        ? const CircularProgressIndicator(color: Color(0xFF4F46E5))
                        : IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF4F46E5)),
                      onPressed: sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(child: _announcementList()),
              if (isOrganizer)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton.icon(
                    onPressed: _showAddAnnouncementDialog,
                    icon: const Icon(Icons.campaign),
                    label: const Text("Add Announcement"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home, "Home", false, () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => const OrganizerHome()), (route) => false);
                }),
                _navItem(Icons.notifications_outlined, "Notifications", false, () {}),
                _navItem(Icons.person_outline, "Profile", false, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const OrganizerProfileScreen()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF), size: 24),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500)),
        ],
      ),
    );
  }
}
