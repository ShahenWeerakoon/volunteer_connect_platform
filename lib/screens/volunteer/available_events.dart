// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // //
// // // class AvailableEvents extends StatelessWidget {
// // //   AvailableEvents({super.key});
// // //
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //
// // //   Future<void> joinEvent(String eventId) async {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     final eventRef = _db.collection('events').doc(eventId);
// // //
// // //     await eventRef.update({
// // //       'participants': FieldValue.arrayUnion([user.uid])
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Available Events")),
// // //       body: StreamBuilder<QuerySnapshot>(
// // //         stream: _db.collection('events').snapshots(),
// // //         builder: (context, snapshot) {
// // //           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
// // //
// // //           final events = snapshot.data!.docs;
// // //
// // //           if (events.isEmpty) return const Center(child: Text("No events available"));
// // //
// // //           return ListView.builder(
// // //             itemCount: events.length,
// // //             itemBuilder: (context, index) {
// // //               final event = events[index].data() as Map<String, dynamic>;
// // //               final eventId = events[index].id;
// // //
// // //               return Card(
// // //                 margin: const EdgeInsets.all(8.0),
// // //                 child: ListTile(
// // //                   title: Text(event['title'] ?? 'No Title'),
// // //                   subtitle: Text(event['description'] ?? 'No Description'),
// // //                   trailing: ElevatedButton(
// // //                     child: const Text("Join"),
// // //                     onPressed: () async {
// // //                       await joinEvent(eventId);
// // //                       ScaffoldMessenger.of(context).showSnackBar(
// // //                         const SnackBar(content: Text("Joined event successfully")),
// // //                       );
// // //                     },
// // //                   ),
// // //                 ),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../../services/firestore_service.dart';
// //
// // class AvailableEvents extends StatelessWidget {
// //   AvailableEvents({super.key});
// //
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirestoreService _firestoreService = FirestoreService();
// //
// //   Future<void> joinEvent(String eventId) async {
// //     final user = _auth.currentUser;
// //     if (user == null) return;
// //
// //     await _firestoreService.registerForEvent(
// //       eventId: eventId,
// //       userId: user.uid,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Available Events")),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: _firestoreService.getAllEvents(),
// //         builder: (context, snapshot) {
// //           if (!snapshot.hasData) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //
// //           final events = snapshot.data!.docs;
// //
// //           if (events.isEmpty) {
// //             return const Center(child: Text("No events available"));
// //           }
// //
// //           return ListView.builder(
// //             itemCount: events.length,
// //             itemBuilder: (context, index) {
// //               final event = events[index].data() as Map<String, dynamic>;
// //               final eventId = events[index].id;
// //
// //               return Card(
// //                 margin: const EdgeInsets.all(10),
// //                 child: ListTile(
// //                   title: Text(event['title'] ?? 'No Title'),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(event['description'] ?? ''),
// //                       const SizedBox(height: 4),
// //                       Text("Location: ${event['location']}"),
// //                       Text("Organizer: ${event['organizerName']}"),
// //                     ],
// //                   ),
// //                   trailing: ElevatedButton(
// //                     child: const Text("Join"),
// //                     onPressed: () async {
// //                       await joinEvent(eventId);
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         const SnackBar(
// //                           content: Text("Joined event successfully"),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../services/firestore_service.dart';
//
// class AvailableEvents extends StatelessWidget {
//   AvailableEvents({super.key});
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirestoreService _firestoreService = FirestoreService();
//
//   // Step 1: Show a dialog to confirm joining
//   Future<bool?> _showJoinConfirmation(BuildContext context, String title) async {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Join Event"),
//         content: Text("Are you sure you want to join the event \"$title\"?"),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.of(context).pop(false),
//           ),
//           ElevatedButton(
//             child: const Text("Confirm"),
//             onPressed: () => Navigator.of(context).pop(true),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Step 2: Show a form to collect extra details before joining
//   Future<Map<String, String>?> _showRegistrationForm(BuildContext context) async {
//     final phoneController = TextEditingController();
//     final emergencyController = TextEditingController();
//     final skillsController = TextEditingController();
//
//     return showDialog<Map<String, String>>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Complete Registration"),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(labelText: "Phone Number"),
//               ),
//               TextField(
//                 controller: emergencyController,
//                 decoration: const InputDecoration(labelText: "Emergency Contact"),
//               ),
//               TextField(
//                 controller: skillsController,
//                 decoration: const InputDecoration(labelText: "Skills / Preferences"),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.of(context).pop(null),
//           ),
//           ElevatedButton(
//             child: const Text("Submit"),
//             onPressed: () {
//               Navigator.of(context).pop({
//                 'phone': phoneController.text.trim(),
//                 'emergency': emergencyController.text.trim(),
//                 'skills': skillsController.text.trim(),
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Step 3: Register volunteer after confirmation & form submission
//   Future<void> joinEvent(BuildContext context, String eventId, String title) async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // 1. Confirmation dialog
//     final confirmed = await _showJoinConfirmation(context, title);
//     if (confirmed != true) return;
//
//     // 2. Registration form
//     final details = await _showRegistrationForm(context);
//     if (details == null) return; // Cancelled
//
//     // 3. Register in Firestore
//     await _firestoreService.registerForEvent(
//       eventId: eventId,
//       userId: user.uid,
//       phone: details['phone'] ?? '',
//       emergencyContact: details['emergency'] ?? '',
//       skills: details['skills'] ?? '',
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Joined event successfully")),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Available Events")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestoreService.getAllEvents(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//
//           final events = snapshot.data!.docs;
//
//           if (events.isEmpty) return const Center(child: Text("No events available"));
//
//           return ListView.builder(
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final event = events[index].data() as Map<String, dynamic>;
//               final eventId = events[index].id;
//
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(event['title'] ?? 'No Title'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(event['description'] ?? ''),
//                       const SizedBox(height: 4),
//                       Text("Location: ${event['location']}"),
//                       Text("Organizer: ${event['organizerName']}"),
//                     ],
//                   ),
//                   trailing: ElevatedButton(
//                     child: const Text("Join"),
//                     onPressed: () => joinEvent(context, eventId, event['title'] ?? ''),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../services/firestore_service.dart';
//
// class AvailableEvents extends StatelessWidget {
//   AvailableEvents({super.key});
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirestoreService _firestoreService = FirestoreService();
//
//   // Step 1: Show a dialog to confirm joining
//   Future<bool?> _showJoinConfirmation(BuildContext context, String title) async {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Join Event"),
//         content: Text("Are you sure you want to join the event \"$title\"?"),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.of(context).pop(false),
//           ),
//           ElevatedButton(
//             child: const Text("Confirm"),
//             onPressed: () => Navigator.of(context).pop(true),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Step 2: Show a form to collect extra details before joining
//   Future<Map<String, String>?> _showRegistrationForm(BuildContext context) async {
//     final phoneController = TextEditingController();
//     final emergencyController = TextEditingController();
//     final skillsController = TextEditingController();
//
//     return showDialog<Map<String, String>>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Complete Registration"),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(labelText: "Phone Number"),
//               ),
//               TextField(
//                 controller: emergencyController,
//                 decoration: const InputDecoration(labelText: "Emergency Contact"),
//               ),
//               TextField(
//                 controller: skillsController,
//                 decoration: const InputDecoration(labelText: "Skills / Preferences"),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.of(context).pop(null),
//           ),
//           ElevatedButton(
//             child: const Text("Submit"),
//             onPressed: () {
//               Navigator.of(context).pop({
//                 'phone': phoneController.text.trim(),
//                 'emergency': emergencyController.text.trim(),
//                 'skills': skillsController.text.trim(),
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Step 3: Register volunteer after confirmation & form submission
//   Future<void> joinEvent(BuildContext context, String eventId, String title) async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // 1. Confirmation dialog
//     final confirmed = await _showJoinConfirmation(context, title);
//     if (confirmed != true) return;
//
//     // 2. Registration form
//     final details = await _showRegistrationForm(context);
//     if (details == null) return; // Cancelled
//
//     // 3. Register in Firestore
//     await _firestoreService.registerForEvent(
//       eventId: eventId,
//       userId: user.uid,
//       phone: details['phone'] ?? '',
//       emergencyContact: details['emergency'] ?? '',
//       skills: details['skills'] ?? '',
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Joined event successfully")),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Available Events")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestoreService.getAllEvents(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//
//           final events = snapshot.data!.docs;
//
//           if (events.isEmpty) return const Center(child: Text("No events available"));
//
//           return ListView.builder(
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final event = events[index].data() as Map<String, dynamic>;
//               final eventId = events[index].id;
//
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(event['title'] ?? 'No Title'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(event['description'] ?? ''),
//                       const SizedBox(height: 4),
//                       Text("Location: ${event['location']}"),
//                       Text("Organizer: ${event['organizerName']}"),
//                     ],
//                   ),
//                   trailing: ElevatedButton(
//                     child: const Text("Join"),
//                     onPressed: () => joinEvent(context, eventId, event['title'] ?? ''),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore_service.dart';

class AvailableEvents extends StatelessWidget {
  AvailableEvents({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Step 1: Confirmation dialog
  Future<bool?> _showJoinConfirmation(BuildContext context, String title) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Join Event"),
        content: Text("Are you sure you want to join the event \"$title\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  // Step 2: Registration form
  Future<Map<String, String>?> _showRegistrationForm(BuildContext context) async {
    final phoneController = TextEditingController();
    final emergencyController = TextEditingController();
    final skillsController = TextEditingController();

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Complete Registration"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              TextField(
                controller: emergencyController,
                decoration: const InputDecoration(labelText: "Emergency Contact"),
              ),
              TextField(
                controller: skillsController,
                decoration: const InputDecoration(labelText: "Skills"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'phone': phoneController.text.trim(),
                'emergency': emergencyController.text.trim(),
                'skills': skillsController.text.trim(),
              });
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  // Step 3: Join event
  Future<void> joinEvent(BuildContext context, String eventId, String title) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final confirmed = await _showJoinConfirmation(context, title);
    if (confirmed != true) return;

    final details = await _showRegistrationForm(context);
    if (details == null) return;

    await _firestoreService.registerForEvent(
      eventId: eventId,
      userId: user.uid,
      name: user.displayName ?? 'Unknown',
      email: user.email ?? '',
      phone: details['phone'] ?? '',
      emergencyContact: details['emergency'] ?? '',
      skills: details['skills'] ?? '',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Joined event successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Events")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getAllEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!.docs;
          if (events.isEmpty) {
            return const Center(child: Text("No events available"));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;
              final eventId = events[index].id;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(event['title'] ?? 'No Title'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['description'] ?? ''),
                      const SizedBox(height: 4),
                      Text("Location: ${event['location']}"),
                      Text("Organizer: ${event['organizerName']}"),
                    ],
                  ),
                  trailing: ElevatedButton(
                    child: const Text("Join"),
                    onPressed: () =>
                        joinEvent(context, eventId, event['title'] ?? ''),
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