// // lib/screens/organization/my_events_screen.dart
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../services/firestore_service.dart';
// import 'volunteers_list_screen.dart';
// import 'edit_event_screen.dart';
//
// class MyEventsScreen extends StatelessWidget {
//   final String organizerId;
//   MyEventsScreen({super.key, required this.organizerId});
//
//   final FirestoreService _firestoreService = FirestoreService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Events")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestoreService.getEventsByOrganizer(organizerId),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final events = snapshot.data!.docs;
//
//           if (events.isEmpty) {
//             return const Center(child: Text("No events created yet."));
//           }
//
//           return ListView.builder(
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final doc = events[index];
//               final event = doc.data() as Map<String, dynamic>;
//
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 elevation: 3,
//                 child: ListTile(
//                   title: Text(event['title']),
//                   subtitle: Text(event['description'] ?? ""),
//                   trailing: PopupMenuButton(
//                     itemBuilder: (_) => [
//                       const PopupMenuItem(value: 'edit', child: Text("Edit")),
//                       const PopupMenuItem(value: 'delete', child: Text("Delete")),
//                       const PopupMenuItem(
//                           value: 'volunteers', child: Text("View Volunteers")),
//                     ],
//                     onSelected: (value) async {
//                       if (value == 'edit') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => EditEventScreen(
//                               eventId: doc.id,
//                               eventData: event,
//                             ),
//                           ),
//                         );
//                       } else if (value == 'delete') {
//                         bool confirmed = await _showConfirmDialog(context);
//                         if (confirmed) await doc.reference.delete();
//                       } else if (value == 'volunteers') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => VolunteersListScreen(
//                               eventId: doc.id,
//                               eventTitle: event['title'],
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // Confirmation dialog for delete
//   Future<bool> _showConfirmDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Confirm Delete"),
//         content: const Text("Are you sure you want to delete this event?"),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text("Cancel")),
//           TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text("Delete")),
//         ],
//       ),
//     ) ??
//         false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import 'volunteers_list_screen.dart';
import 'edit_event_screen.dart';
import 'chatroom_screen.dart';
import 'organizer_home.dart';
import 'organizer_profile_screen.dart';

class MyEventsScreen extends StatelessWidget {
  final String organizerId;

  MyEventsScreen({super.key, required this.organizerId});

  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _announcementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "My Events",
          style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getEventsByOrganizer(organizerId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final events = snapshot.data!.docs;
          if (events.isEmpty) {
            return const Center(
              child: Text(
                "No events created yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final doc = events[index];
              final event = doc.data() as Map<String, dynamic>;
              return _eventCard(context, doc.id, event);
            },
          );
        },
      ),
      bottomNavigationBar: _bottomBar(context),
    );
  }

  /// ======================
  /// EVENT CARD
  /// ======================
  Widget _eventCard(BuildContext context, String eventId, Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Event title
            Text(
              event['title'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 6),

            /// Event description
            Text(
              event['description'] ?? "",
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 6),

            /// Event date
            Text(
              "Date: ${event['date'] != null ? (event['date'] as Timestamp).toDate().toLocal().toString().split(' ')[0] : 'Not set'}",
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
            const SizedBox(height: 12),

            /// Action buttons: Edit, Delete, Volunteers, Announcement, Chat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardButton(Icons.edit, "Edit", () => _editEvent(context, eventId, event)),
                _cardButton(Icons.delete, "Delete", () => _deleteEvent(context, eventId)),
                _cardButton(Icons.group, "Volunteers", () => _viewVolunteers(context, eventId, event['title'])),
                _cardButton(Icons.campaign, "Announce", () => _postAnnouncement(context, eventId, event['title'])),
                _cardButton(Icons.chat, "Chat", () => _openChat(context, eventId, event['title'])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF4F46E5)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF4F46E5))),
        ],
      ),
    );
  }

  /// ======================
  /// ANNOUNCEMENT
  /// ======================
  void _postAnnouncement(BuildContext context, String eventId, String eventTitle) {
    _announcementController.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Announcement", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Event: $eventTitle", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
            ),
            onPressed: () async {
              final text = _announcementController.text.trim();
              if (text.isEmpty) return;
              await _firestoreService.addAnnouncement(
                eventId: eventId,
                senderId: organizerId,
                senderName: "Organizer",
                message: text,
                eventName: eventTitle, // Include event name in Firestore
              );
              _announcementController.clear();
              Navigator.pop(context);
            },
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }

  /// ======================
  /// OTHER ACTIONS
  /// ======================
  void _editEvent(BuildContext context, String eventId, Map<String, dynamic> event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditEventScreen(eventId: eventId, eventData: event),
      ),
    );
  }

  void _deleteEvent(BuildContext context, String eventId) async {
    bool confirmed = await _showConfirmDialog(context, "Are you sure you want to delete this event?");
    if (confirmed) {
      await _firestoreService.updateEvent(
        eventId: eventId,
        title: "DELETED",
        description: "DELETED",
        location: "",
        date: DateTime.now(),
      );
    }
  }

  void _viewVolunteers(BuildContext context, String eventId, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VolunteersListScreen(eventId: eventId, eventTitle: title),
      ),
    );
  }

  void _openChat(BuildContext context, String eventId, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatroomScreen(eventId: eventId, eventName: title),
      ),
    );
  }

  Future<bool> _showConfirmDialog(BuildContext context, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Confirm"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    ) ??
        false;
  }

  Widget _bottomBar(BuildContext context) {
    return Container(
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
              _navItem(Icons.home, "Home", true, () {
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
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
