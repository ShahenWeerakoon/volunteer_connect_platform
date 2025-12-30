import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore_service.dart';

class VolunteerHome extends StatelessWidget {
  VolunteerHome({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    // Updated method name
    final userData = await FirestoreService().getUserData(user.uid);
    return userData;
  }

  void logout(BuildContext context) async {
    await _auth.signOut();
    // AuthWrapper will automatically redirect
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volunteer Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user data found"));
          }

          final userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['name']}", style: const TextStyle(fontSize: 18)),
                Text("Email: ${userData['email']}", style: const TextStyle(fontSize: 16)),
                Text("Phone: ${userData['phone']}", style: const TextStyle(fontSize: 16)),
                Text("Role: ${userData['role']}", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text("Your Actions:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to available events screen
                  },
                  child: const Text("View Available Events"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to your participation history
                  },
                  child: const Text("My Participation History"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
