// lib/screens/organization/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Reports'),
        backgroundColor: const Color(0xFF0099FF),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getOrganizerEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!.docs;

          if (events.isEmpty) {
            return const Center(
              child: Text(
                'No events created yet.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final eventData = event.data() as Map<String, dynamic>;
              final eventId = event.id;
              final title = eventData['title'] ?? 'Untitled Event';
              final date = (eventData['date'] as Timestamp?)?.toDate() ?? DateTime.now();

              return FutureBuilder<int>(
                future: getVolunteerCount(eventId),
                builder: (context, volSnapshot) {
                  final volunteerCount = volSnapshot.data ?? 0;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        'Date: ${date.toLocal().toString().split(' ')[0]}\nVolunteers: $volunteerCount',
                        style: const TextStyle(fontSize: 14),
                      ),
                      leading: const Icon(Icons.event_note, color: Color(0xFF0099FF), size: 32),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Optional: navigate to detailed report for this event
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
