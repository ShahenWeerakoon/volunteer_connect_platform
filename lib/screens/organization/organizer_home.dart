// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../../services/firestore_service.dart';
// // import 'add_event_screen.dart';
// // import 'volunteers_list_screen.dart';
// // import 'EventRegistrationsScreen.dart'; // Make sure this exists
// //
// // class OrganizerHome extends StatelessWidget {
// //   OrganizerHome({super.key});
// //
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirestoreService _firestoreService = FirestoreService();
// //
// //   Future<Map<String, dynamic>?> getCurrentUserData() async {
// //     final user = _auth.currentUser;
// //     if (user == null) return null;
// //     final userData = await _firestoreService.getUserData(user.uid);
// //     return userData;
// //   }
// //
// //   void logout(BuildContext context) async {
// //     await _auth.signOut();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Organizer Dashboard"),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.logout),
// //             onPressed: () => logout(context),
// //           ),
// //         ],
// //       ),
// //       body: FutureBuilder<Map<String, dynamic>?>(
// //         future: getCurrentUserData(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (!snapshot.hasData || snapshot.data == null) {
// //             return const Center(child: Text("No organizer data found"));
// //           }
// //
// //           final userData = snapshot.data!;
// //           final organizerId = _auth.currentUser!.uid;
// //
// //           return Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text("Name: ${userData['name']}", style: const TextStyle(fontSize: 18)),
// //                 Text("Email: ${userData['email']}", style: const TextStyle(fontSize: 16)),
// //                 const SizedBox(height: 20),
// //
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => AddEventScreen(
// //                           organizerId: organizerId,
// //                           organizerName: userData['name'],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: const Text("Add New Event"),
// //                 ),
// //                 const SizedBox(height: 20),
// //
// //                 const Text("Your Events:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                 const SizedBox(height: 10),
// //
// //                 // ✅ Correct Expanded with proper closure
// //                 Expanded(
// //                   child: StreamBuilder<QuerySnapshot>(
// //                     stream: _firestoreService.getEventsByOrganizer(organizerId),
// //                     builder: (context, eventSnapshot) {
// //                       if (!eventSnapshot.hasData) {
// //                         return const Center(child: CircularProgressIndicator());
// //                       }
// //
// //                       final events = eventSnapshot.data!.docs;
// //
// //                       if (events.isEmpty) {
// //                         return const Center(child: Text("No events created yet"));
// //                       }
// //
// //                       return ListView.builder(
// //                         itemCount: events.length,
// //                         itemBuilder: (context, index) {
// //                           final event = events[index].data() as Map<String, dynamic>;
// //                           final eventId = events[index].id;
// //
// //                           return Card(
// //                             margin: const EdgeInsets.symmetric(vertical: 6),
// //                             child: ListTile(
// //                               title: Text(event['title'] ?? 'No Title'),
// //                               subtitle: Text(event['description'] ?? ''),
// //                               trailing: ElevatedButton(
// //                                 child: const Text("View Volunteers"),
// //                                 onPressed: () {
// //                                   Navigator.push(
// //                                     context,
// //                                     MaterialPageRoute(
// //                                       builder: (_) => VolunteersListScreen(
// //                                         eventId: eventId,
// //                                         eventTitle: event['title'] ?? 'No Title',
// //                                       ),
// //                                     ),
// //                                   );
// //                                 },
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       );
// //                     },
// //                   ),
// //                 ), // ✅ Expanded closed here
// //
// //                 const SizedBox(height: 12),
// //
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => EventRegistrationsScreen(
// //                           organizerId: organizerId,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: const Text("View My Event Registrations"),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// // lib/screens/organization/organizer_home.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'add_event_screen.dart';
// import 'EventRegistrationsScreen.dart';
// import 'my_events_screen.dart';
//
// class OrganizerHome extends StatelessWidget {
//   const OrganizerHome({super.key});
//
//   final String welcomeEmoji = "👋";
//
//   void logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final organizerId = FirebaseAuth.instance.currentUser!.uid;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       appBar: AppBar(
//         title: const Text("Organizer Dashboard"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => logout(context),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: const Icon(Icons.add),
//         label: const Text("Create Event"),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddEventScreen(
//                 organizerId: organizerId,
//                 organizerName: "",
//               ),
//             ),
//           );
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Welcome, Organizer $welcomeEmoji",
//               style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.indigo),
//             ),
//             const SizedBox(height: 20),
//             // Stats Row
//             Row(
//               children: [
//                 _statCard("Events", Icons.event, Colors.blue),
//                 const SizedBox(width: 12),
//                 _statCard("Volunteers", Icons.groups, Colors.green),
//                 const SizedBox(width: 12),
//                 _statCard("Pending", Icons.pending, Colors.orange),
//               ],
//             ),
//             const SizedBox(height: 30),
//             const Text(
//               "Quick Actions",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             _actionTile(
//               icon: Icons.event_note,
//               title: "My Events",
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => MyEventsScreen(
//                       organizerId: organizerId,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             _actionTile(
//               icon: Icons.list_alt,
//               title: "Event Registrations",
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         EventRegistrationsScreen(organizerId: organizerId),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Stat Card Widget
//   Widget _statCard(String title, IconData icon, Color color) {
//     return Expanded(
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           child: Column(
//             children: [
//               Icon(icon, size: 32, color: color),
//               const SizedBox(height: 8),
//               Text(title,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 16)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Quick Action Tile Widget
//   Widget _actionTile({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.indigo),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//         onTap: onTap,
//       ),
//     );
//   }
// }

// lib/screens/organization/organizer_home.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_event_screen.dart';
import 'my_events_screen.dart';
import 'organizer_profile_screen.dart';

class OrganizerHome extends StatefulWidget {
  const OrganizerHome({super.key});

  @override
  State<OrganizerHome> createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String organizerName = '';
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadOrganizerData();
  }

  Future<void> _loadOrganizerData() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        organizerName = data['name'] ?? '';
        profileImageUrl = data['profileImage'] ?? '';
      });
    }
  }

  void logout(BuildContext context) async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final organizerId = _auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Organizer Dashboard"),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: profileImageUrl.isNotEmpty
                  ? NetworkImage(profileImageUrl)
                  : const AssetImage('assets/avatar_placeholder.png')
              as ImageProvider,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrganizerProfileScreen(),
                ),
              ).then((_) => _loadOrganizerData()); // refresh after profile update
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Create Event"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEventScreen(
                organizerId: organizerId,
                organizerName: organizerName,
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, $organizerName 👋",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 20),
            // Stats Row
            Row(
              children: [
                _statCard("Events", Icons.event, Colors.blue),
                const SizedBox(width: 12),
                _statCard("Volunteers", Icons.groups, Colors.green),
                const SizedBox(width: 12),
                _statCard("Pending", Icons.pending, Colors.orange),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _actionTile(
              icon: Icons.event_note,
              title: "My Events",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyEventsScreen(
                      organizerId: organizerId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Stat Card Widget
  Widget _statCard(String title, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Action Tile Widget
  Widget _actionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
