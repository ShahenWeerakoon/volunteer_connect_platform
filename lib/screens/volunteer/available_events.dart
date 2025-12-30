import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AvailableEvents extends StatelessWidget {
  AvailableEvents({super.key});

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> joinEvent(String eventId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final eventRef = _db.collection('events').doc(eventId);

    await eventRef.update({
      'participants': FieldValue.arrayUnion([user.uid])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Events")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final events = snapshot.data!.docs;

          if (events.isEmpty) return const Center(child: Text("No events available"));

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;
              final eventId = events[index].id;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(event['title'] ?? 'No Title'),
                  subtitle: Text(event['description'] ?? 'No Description'),
                  trailing: ElevatedButton(
                    child: const Text("Join"),
                    onPressed: () async {
                      await joinEvent(eventId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Joined event successfully")),
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
