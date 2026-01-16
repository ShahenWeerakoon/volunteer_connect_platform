// lib/screens/organization/my_events_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import 'volunteers_list_screen.dart';
import 'edit_event_screen.dart';

class MyEventsScreen extends StatelessWidget {
  final String organizerId;
  MyEventsScreen({super.key, required this.organizerId});

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Events")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getEventsByOrganizer(organizerId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!.docs;

          if (events.isEmpty) {
            return const Center(child: Text("No events created yet."));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final doc = events[index];
              final event = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: ListTile(
                  title: Text(event['title']),
                  subtitle: Text(event['description'] ?? ""),
                  trailing: PopupMenuButton(
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: Text("Edit")),
                      const PopupMenuItem(value: 'delete', child: Text("Delete")),
                      const PopupMenuItem(
                          value: 'volunteers', child: Text("View Volunteers")),
                    ],
                    onSelected: (value) async {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditEventScreen(
                              eventId: doc.id,
                              eventData: event,
                            ),
                          ),
                        );
                      } else if (value == 'delete') {
                        bool confirmed = await _showConfirmDialog(context);
                        if (confirmed) await doc.reference.delete();
                      } else if (value == 'volunteers') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VolunteersListScreen(
                              eventId: doc.id,
                              eventTitle: event['title'],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Confirmation dialog for delete
  Future<bool> _showConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Delete")),
        ],
      ),
    ) ??
        false;
  }
}
