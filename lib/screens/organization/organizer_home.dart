// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../services/firestore_service.dart';
// import 'add_event_screen.dart'; // We'll create this next
//
// class OrganizerHome extends StatelessWidget {
//   OrganizerHome({super.key});
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirestoreService _firestoreService = FirestoreService();
//
//   Future<Map<String, dynamic>?> getCurrentUserData() async {
//     final user = _auth.currentUser;
//     if (user == null) return null;
//
//     final userData = await _firestoreService.getUserData(user.uid);
//     return userData;
//   }
//
//   void logout(BuildContext context) async {
//     await _auth.signOut();
//     // AuthWrapper will automatically redirect
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Organizer Dashboard"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => logout(context),
//           )
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: getCurrentUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(child: Text("No organizer data found"));
//           }
//
//           final userData = snapshot.data!;
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Name: ${userData['name']}", style: const TextStyle(fontSize: 18)),
//                 Text("Email: ${userData['email']}", style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Add Event screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AddEventScreen(
//                           organizerId: _auth.currentUser!.uid,
//                           organizerName: userData['name'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: const Text("Add New Event"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';
import 'add_event_screen.dart';
import 'volunteers_list_screen.dart'; // Make sure this exists

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
          ),
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
          final organizerId = _auth.currentUser!.uid;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['name']}", style: const TextStyle(fontSize: 18)),
                Text("Email: ${userData['email']}", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),

                // Add Event button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEventScreen(
                          organizerId: organizerId,
                          organizerName: userData['name'],
                        ),
                      ),
                    );
                  },
                  child: const Text("Add New Event"),
                ),
                const SizedBox(height: 20),
                const Text("Your Events:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                // List of events created by this organizer
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestoreService.getAllEvents(),
                    builder: (context, eventSnapshot) {
                      if (!eventSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // Filter events by this organizer
                      final events = eventSnapshot.data!.docs
                          .where((doc) => doc['organizerId'] == organizerId)
                          .toList();

                      if (events.isEmpty) {
                        return const Center(child: Text("No events created yet"));
                      }

                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index].data() as Map<String, dynamic>;
                          final eventId = events[index].id;

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
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

                const SizedBox(height: 12),

                // View Event Registrations button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventRegistrationsScreen(
                          organizerId: _auth.currentUser!.uid,
                        ),
                      ),
                    );
                  },
                  child: const Text("View My Event Registrations"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
