import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: logout)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No users registered yet."));

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final isCurrentUser = currentUser?.uid == user.id;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isCurrentUser ? Colors.blue.shade50 : Colors.white,
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(child: Text(user['name']?[0].toUpperCase() ?? '?')),
                  title: Text(user['name'] ?? 'No Name', style: TextStyle(fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal)),
                  subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Email: ${user['email']}"),
                    Text("Phone: ${user['phone'] ?? 'N/A'}"),
                    Text("Role: ${user['role'] ?? 'N/A'}"),
                  ]),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
