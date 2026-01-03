import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class VolunteersListScreen extends StatelessWidget {
  final String eventId;
  final String eventTitle;

  VolunteersListScreen({
    super.key,
    required this.eventId,
    required this.eventTitle,
  });

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteers – $eventTitle"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // ✅ Use the correct FirestoreService method
        stream: _firestoreService.getRegistrationsForEvent(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No volunteers registered yet"));
          }

          final volunteers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: volunteers.length,
            itemBuilder: (context, index) {
              final data = volunteers[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'] ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
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
