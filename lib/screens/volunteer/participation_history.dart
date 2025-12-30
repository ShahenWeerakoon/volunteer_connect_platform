import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParticipationHistory extends StatelessWidget {
  ParticipationHistory({super.key});

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    if (user == null) return const Scaffold(body: Center(child: Text("User not logged in")));

    return Scaffold(
      appBar: AppBar(title: const Text("My Participation History")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('events').where('participants', arrayContains: user.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final events = snapshot.data!.docs;

          if (events.isEmpty) return const Center(child: Text("You haven't joined any events yet"));

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(event['title'] ?? 'No Title'),
                  subtitle: Text(event['description'] ?? 'No Description'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
