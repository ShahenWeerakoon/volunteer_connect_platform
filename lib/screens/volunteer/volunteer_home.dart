// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../../services/firestore_service.dart';
// //
// // class VolunteerHome extends StatelessWidget {
// //   VolunteerHome({super.key});
// //
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   Future<Map<String, dynamic>?> getCurrentUserData() async {
// //     final user = _auth.currentUser;
// //     if (user == null) return null;
// //
// //     // Updated method name
// //     final userData = await FirestoreService().getUserData(user.uid);
// //     return userData;
// //   }
// //
// //   void logout(BuildContext context) async {
// //     await _auth.signOut();
// //     // AuthWrapper will automatically redirect
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Volunteer Dashboard"),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.logout),
// //             onPressed: () => logout(context),
// //           )
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
// //             return const Center(child: Text("No user data found"));
// //           }
// //
// //           final userData = snapshot.data!;
// //           return Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text("Name: ${userData['name']}", style: const TextStyle(fontSize: 18)),
// //                 Text("Email: ${userData['email']}", style: const TextStyle(fontSize: 16)),
// //                 Text("Phone: ${userData['phone']}", style: const TextStyle(fontSize: 16)),
// //                 Text("Role: ${userData['role']}", style: const TextStyle(fontSize: 16)),
// //                 const SizedBox(height: 20),
// //                 const Text("Your Actions:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //                 const SizedBox(height: 10),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     // TODO: Navigate to available events screen
// //                   },
// //                   child: const Text("View Available Events"),
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     // TODO: Navigate to your participation history
// //                   },
// //                   child: const Text("My Participation History"),
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
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../services/firestore_service.dart';
// import 'available_events.dart'; // Screen to list events
// import 'participation_history.dart'; // Screen for history
//
// class VolunteerHome extends StatelessWidget {
//   VolunteerHome({super.key});
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
//         title: const Text("Volunteer Dashboard"),
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
//             return const Center(child: Text("No user data found"));
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
//                 Text("Phone: ${userData['phone']}", style: const TextStyle(fontSize: 16)),
//                 Text("Role: ${userData['role']}", style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 20),
//                 const Text("Your Actions:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => AvailableEvents()),
//                     );
//                   },
//                   child: const Text("View Available Events"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => ParticipationHistory()),
//                     );
//                   },
//                   child: const Text("My Participation History"),
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
import '../../services/firestore_service.dart';
import 'available_events.dart';
import 'participation_history.dart';

class VolunteerHome extends StatelessWidget {
  VolunteerHome({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return await _firestoreService.getUserData(user.uid);
  }

  void logout(BuildContext context) async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user data found"));
          }

          final userData = snapshot.data!;
          final name = userData['name'] ?? '';
          final email = userData['email'] ?? '';
          final phone = userData['phone'] ?? '';
          final role = userData['role'] ?? '';

          // Stats — add these fields to Firestore if not present yet
          final eventsJoined = userData['eventsJoined'] ?? 0;
          final hoursGiven = userData['hoursGiven'] ?? 0;
          final badges = userData['badges'] ?? 0;

          return Column(
            children: [
              // ── Header ──────────────────────────────────────────────
              Container(
                color: const Color(0xFF4F46E5),
                padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Volunteer Dashboard',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Hello, ${name.split(' ').first}!',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white24,
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Stats strip
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _statItem('$eventsJoined', 'Events'),
                          _verticalDivider(),
                          _statItem('${hoursGiven}h', 'Hours'),
                          _verticalDivider(),
                          _statItem('$badges', 'Badges'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Body ─────────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Actions
                      const Text(
                        'YOUR ACTIONS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9CA3AF),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _actionTile(
                        icon: Icons.calendar_month_outlined,
                        title: 'View Available Events',
                        subtitle: 'Browse & register for events',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AvailableEvents())),
                      ),
                      const SizedBox(height: 10),
                      _actionTile(
                        icon: Icons.assignment_outlined,
                        title: 'My Participation History',
                        subtitle: 'Past events & activity',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ParticipationHistory())),
                      ),

                      const SizedBox(height: 24),

                      // User info card
                      const Text(
                        'YOUR INFO',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9CA3AF),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Column(
                          children: [
                            _infoRow('Name', name),
                            _divider(),
                            _infoRow('Email', email),
                            _divider(),
                            _infoRow('Phone', phone),
                            _divider(),
                            _infoRowBadge('Role', role),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Logout
                      GestureDetector(
                        onTap: () => logout(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF5F5),
                            border: Border.all(color: const Color(0xFFFCA5A5)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.logout,
                                  color: Color(0xFFDC2626), size: 18),
                              SizedBox(width: 10),
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFDC2626),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const SizedBox(height: 3),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: Colors.white60)),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 0.5, height: 32, color: Colors.white30);
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF4F46E5), size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827))),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9CA3AF))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Color(0xFF9CA3AF), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF6B7280))),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827))),
        ],
      ),
    );
  }

  Widget _infoRowBadge(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF6B7280))),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(value,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4338CA))),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, color: Color(0xFFE5E7EB));
  }
}