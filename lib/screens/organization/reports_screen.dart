// lib/screens/organization/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'organizer_home.dart';
import 'organizer_profile_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String organizerId = '';

  @override
  void initState() {
    super.initState();
    organizerId = _auth.currentUser!.uid;
  }

  Stream<QuerySnapshot> getOrganizerEvents() {
    return _firestore
        .collection('events')
        .where('organizerId', isEqualTo: organizerId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<int> getVolunteerCount(String eventId) async {
    final snapshot = await _firestore
        .collection('registrations')
        .where('eventId', isEqualTo: eventId)
        .get();
    return snapshot.docs.length;
  }

  Future<Map<String, int>> getOverallStats(List<QueryDocumentSnapshot> events) async {
    int totalVolunteers = 0;
    for (var event in events) {
      totalVolunteers += await getVolunteerCount(event.id);
    }
    return {
      'totalEvents': events.length,
      'totalVolunteers': totalVolunteers,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Event Reports',
          style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF111827)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getOrganizerEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final events = snapshot.data!.docs;

          if (events.isEmpty) {
            return const Center(
              child: Text(
                'No events created yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return FutureBuilder<Map<String, int>>(
            future: getOverallStats(events),
            builder: (context, statsSnapshot) {
              final stats = statsSnapshot.data ??
                  {'totalEvents': 0, 'totalVolunteers': 0};

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ===== Overall Statistics =====
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statCard('Total Events', stats['totalEvents'] ?? 0, Colors.blue),
                        _statCard('Total Volunteers', stats['totalVolunteers'] ?? 0, Colors.green),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ===== Event List =====
                  ...events.map((event) {
                    final eventData = event.data() as Map<String, dynamic>;
                    final eventId = event.id;
                    final title = eventData['title'] ?? 'Untitled Event';
                    final date = (eventData['date'] as Timestamp?)?.toDate() ?? DateTime.now();
                    final isPast = date.isBefore(DateTime.now());

                    return FutureBuilder<int>(
                      future: getVolunteerCount(eventId),
                      builder: (context, volSnapshot) {
                        final volunteerCount = volSnapshot.data ?? 0;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _pillLabel(Icons.calendar_today, '${date.toLocal().toString().split(' ')[0]}', Colors.blue.shade50, Colors.blue),
                                  const SizedBox(width: 8),
                                  _pillLabel(Icons.group, '$volunteerCount Volunteers', Colors.green.shade50, Colors.green),
                                  const SizedBox(width: 8),
                                  _pillLabel(Icons.check_circle, isPast ? 'Completed' : 'Upcoming', isPast ? Colors.grey.shade200 : Colors.orange.shade50, isPast ? Colors.grey : Colors.orange),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: _bottomBar(context),
    );
  }

  // ===== Pill Label =====
  Widget _pillLabel(IconData icon, String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // ===== Stat Card =====
  Widget _statCard(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
      ],
    );
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
              _navItem(Icons.home, "Home", false, () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const OrganizerHome()),
                      (route) => false,
                );
              }),
              _navItem(Icons.bar_chart, "Reports", true, () {}),
              _navItem(Icons.person_outline, "Profile", false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrganizerProfileScreen()),
                );
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
          Icon(
            icon,
            color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
