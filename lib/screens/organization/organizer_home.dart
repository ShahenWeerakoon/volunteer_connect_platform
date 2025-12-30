import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore_service.dart';
import 'add_event_screen.dart'; // We'll create this next

class OrganizerHome extends StatelessWidget {
  OrganizerHome({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final userData = await _firestoreService.getUserData(user.uid);
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
        title: const Text("Organizer Dashboard"),
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
            return const Center(child: Text("No organizer data found"));
          }

          final userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['name']}", style: const TextStyle(fontSize: 18)),
                Text("Email: ${userData['email']}", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Add Event screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEventScreen(
                          organizerId: _auth.currentUser!.uid,
                          organizerName: userData['name'],
                        ),
                      ),
                    );
                  },
                  child: const Text("Add New Event"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
