import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class VolunteersListScreen extends StatelessWidget {
  final String eventId;
  final String eventTitle;
  final FirestoreService _firestoreService = FirestoreService();

  VolunteersListScreen({super.key, required this.eventId, required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Volunteers for $eventTitle")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getEventRegistrations(eventId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final registrations = snapshot.data!.docs;

          if (registrations.isEmpty) return const Center(child: Text("No volunteers registered yet"));

          return ListView.builder(
            itemCount: registrations.length,
            itemBuilder: (context, index) {
              final data = registrations[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(data['name'] ?? 'Unknown'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: ${data['email'] ?? '-'}"),
                      Text("Phone: ${data['phone'] ?? '-'}"),
                      Text("Emergency: ${data['emergencyContact'] ?? '-'}"),
                      Text("Skills: ${data['skills'] ?? '-'}"),
                    ],
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
