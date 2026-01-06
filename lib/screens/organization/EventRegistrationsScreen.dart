import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';
import 'volunteers_list_screen.dart'; // Make sure this exists

class EventRegistrationsScreen extends StatelessWidget {
  final String organizerId; // Currently logged-in organizer
  final FirestoreService _firestoreService = FirestoreService();

  EventRegistrationsScreen({super.key, required this.organizerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Event Registrations")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getEventsByOrganizer(organizerId), // Optimized query
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No events found"));
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;
              final eventId = events[index].id;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(event['title'] ?? 'No Title'),
                  subtitle: Text(event['description'] ?? ''),
                  trailing: ElevatedButton(
                    child: const Text("View Volunteers"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VolunteersListScreen(
                            eventId: eventId,
                            eventTitle: event['title'] ?? 'No Title',
                          ),
                        ),
                      );
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
}
