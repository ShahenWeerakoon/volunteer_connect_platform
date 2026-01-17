// // // // // // lib/screens/organization/organizer_home.dart
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // //
// // // // // import 'add_event_screen.dart';
// // // // // import 'my_events_screen.dart';
// // // // // import 'organizer_profile_screen.dart';
// // // // //
// // // // // class OrganizerHome extends StatefulWidget {
// // // // //   const OrganizerHome({super.key});
// // // // //
// // // // //   @override
// // // // //   State<OrganizerHome> createState() => _OrganizerHomeState();
// // // // // }
// // // // //
// // // // // class _OrganizerHomeState extends State<OrganizerHome> {
// // // // //   final _auth = FirebaseAuth.instance;
// // // // //   final _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   String organizerName = '';
// // // // //   String profileImageUrl = '';
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _loadOrganizerData();
// // // // //   }
// // // // //
// // // // //   Future<void> _loadOrganizerData() async {
// // // // //     final uid = _auth.currentUser!.uid;
// // // // //     final doc = await _firestore.collection('users').doc(uid).get();
// // // // //     if (doc.exists) {
// // // // //       final data = doc.data()!;
// // // // //       setState(() {
// // // // //         organizerName = data['name'] ?? '';
// // // // //         profileImageUrl = data['profileImage'] ?? '';
// // // // //       });
// // // // //     }
// // // // //   }
// // // // //
// // // // //   void logout(BuildContext context) async {
// // // // //     await _auth.signOut();
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final organizerId = _auth.currentUser!.uid;
// // // // //
// // // // //     return Scaffold(
// // // // //       backgroundColor: const Color(0xFFF8F9FD),
// // // // //       appBar: AppBar(
// // // // //         elevation: 0,
// // // // //         backgroundColor: Colors.white,
// // // // //         title: const Text(
// // // // //           "Organizer Dashboard",
// // // // //           style: TextStyle(
// // // // //             color: Color(0xFF2D3748),
// // // // //             fontWeight: FontWeight.w700,
// // // // //             fontSize: 20,
// // // // //           ),
// // // // //         ),
// // // // //         actions: [
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.only(right: 8),
// // // // //             child: IconButton(
// // // // //               icon: Container(
// // // // //                 width: 38,
// // // // //                 height: 38,
// // // // //                 decoration: BoxDecoration(
// // // // //                   shape: BoxShape.circle,
// // // // //                   border: Border.all(
// // // // //                     color: const Color(0xFF6366F1),
// // // // //                     width: 2,
// // // // //                   ),
// // // // //                   image: profileImageUrl.isNotEmpty
// // // // //                       ? DecorationImage(
// // // // //                     image: NetworkImage(profileImageUrl),
// // // // //                     fit: BoxFit.cover,
// // // // //                   )
// // // // //                       : null,
// // // // //                 ),
// // // // //                 child: profileImageUrl.isEmpty
// // // // //                     ? const Icon(
// // // // //                   Icons.person,
// // // // //                   color: Color(0xFF6366F1),
// // // // //                   size: 20,
// // // // //                 )
// // // // //                     : null,
// // // // //               ),
// // // // //               onPressed: () {
// // // // //                 Navigator.push(
// // // // //                   context,
// // // // //                   MaterialPageRoute(
// // // // //                     builder: (_) => const OrganizerProfileScreen(),
// // // // //                   ),
// // // // //                 ).then((_) => _loadOrganizerData());
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.only(right: 12),
// // // // //             child: IconButton(
// // // // //               icon: const Icon(
// // // // //                 Icons.logout_rounded,
// // // // //                 color: Color(0xFF6B7280),
// // // // //               ),
// // // // //               onPressed: () => logout(context),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //
// // // // //       floatingActionButton: FloatingActionButton.extended(
// // // // //         icon: const Icon(Icons.add_rounded),
// // // // //         label: const Text(
// // // // //           "Create Event",
// // // // //           style: TextStyle(
// // // // //             fontWeight: FontWeight.w600,
// // // // //             fontSize: 15,
// // // // //           ),
// // // // //         ),
// // // // //         backgroundColor: const Color(0xFF6366F1),
// // // // //         elevation: 4,
// // // // //         onPressed: () {
// // // // //           Navigator.push(
// // // // //             context,
// // // // //             MaterialPageRoute(
// // // // //               builder: (_) => AddEventScreen(
// // // // //                 organizerId: organizerId,
// // // // //                 organizerName: organizerName,
// // // // //               ),
// // // // //             ),
// // // // //           );
// // // // //         },
// // // // //       ),
// // // // //
// // // // //       body: SingleChildScrollView(
// // // // //         padding: const EdgeInsets.all(20),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             // Welcome Section
// // // // //             Container(
// // // // //               width: double.infinity,
// // // // //               padding: const EdgeInsets.all(24),
// // // // //               decoration: BoxDecoration(
// // // // //                 gradient: const LinearGradient(
// // // // //                   begin: Alignment.topLeft,
// // // // //                   end: Alignment.bottomRight,
// // // // //                   colors: [
// // // // //                     Color(0xFF6366F1),
// // // // //                     Color(0xFF8B5CF6),
// // // // //                   ],
// // // // //                 ),
// // // // //                 borderRadius: BorderRadius.circular(20),
// // // // //                 boxShadow: [
// // // // //                   BoxShadow(
// // // // //                     color: const Color(0xFF6366F1).withOpacity(0.3),
// // // // //                     blurRadius: 20,
// // // // //                     offset: const Offset(0, 10),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   const Text(
// // // // //                     "Welcome back,",
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 15,
// // // // //                       color: Colors.white70,
// // // // //                       fontWeight: FontWeight.w500,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 6),
// // // // //                   Text(
// // // // //                     organizerName.isNotEmpty ? organizerName : "Organizer",
// // // // //                     style: const TextStyle(
// // // // //                       fontSize: 28,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.white,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 8),
// // // // //                   const Text(
// // // // //                     "👋 Ready to create amazing events?",
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 14,
// // // // //                       color: Colors.white70,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //
// // // // //             const SizedBox(height: 36),
// // // // //
// // // // //             // Action Cards
// // // // //             Row(
// // // // //               children: [
// // // // //                 _optionCard(
// // // // //                   title: "My Events",
// // // // //                   icon: Icons.event_note_rounded,
// // // // //                   color: const Color(0xFF6366F1),
// // // // //                   onTap: () {
// // // // //                     Navigator.push(
// // // // //                       context,
// // // // //                       MaterialPageRoute(
// // // // //                         builder: (_) => MyEventsScreen(
// // // // //                           organizerId: organizerId,
// // // // //                         ),
// // // // //                       ),
// // // // //                     );
// // // // //                   },
// // // // //                 ),
// // // // //                 const SizedBox(width: 16),
// // // // //                 _optionCard(
// // // // //                   title: "Volunteers",
// // // // //                   icon: Icons.groups_rounded,
// // // // //                   color: const Color(0xFF10B981),
// // // // //                   onTap: () {
// // // // //                     // TODO: Navigate to Volunteers Screen
// // // // //                   },
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _optionCard({
// // // // //     required String title,
// // // // //     required IconData icon,
// // // // //     required Color color,
// // // // //     required VoidCallback onTap,
// // // // //   }) {
// // // // //     return Expanded(
// // // // //       child: Material(
// // // // //         color: Colors.transparent,
// // // // //         child: InkWell(
// // // // //           onTap: onTap,
// // // // //           borderRadius: BorderRadius.circular(20),
// // // // //           child: Container(
// // // // //             height: 180,
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.white,
// // // // //               borderRadius: BorderRadius.circular(20),
// // // // //               boxShadow: [
// // // // //                 BoxShadow(
// // // // //                   color: Colors.black.withOpacity(0.04),
// // // // //                   blurRadius: 20,
// // // // //                   offset: const Offset(0, 4),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             child: Padding(
// // // // //               padding: const EdgeInsets.all(24),
// // // // //               child: Column(
// // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                 children: [
// // // // //                   Container(
// // // // //                     width: 64,
// // // // //                     height: 64,
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: color.withOpacity(0.1),
// // // // //                       borderRadius: BorderRadius.circular(16),
// // // // //                     ),
// // // // //                     child: Icon(
// // // // //                       icon,
// // // // //                       size: 32,
// // // // //                       color: color,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 16),
// // // // //                   Text(
// // // // //                     title,
// // // // //                     style: const TextStyle(
// // // // //                       fontSize: 17,
// // // // //                       fontWeight: FontWeight.w700,
// // // // //                       color: Color(0xFF2D3748),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // //
// // // // //WhatsApp theme
// // // // // lib/screens/organization/organizer_home.dart
// // // // import 'package:flutter/material.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // //
// // // // import 'add_event_screen.dart';
// // // // import 'my_events_screen.dart';
// // // // import 'organizer_profile_screen.dart';
// // // //
// // // // class OrganizerHome extends StatefulWidget {
// // // //   const OrganizerHome({super.key});
// // // //
// // // //   @override
// // // //   State<OrganizerHome> createState() => _OrganizerHomeState();
// // // // }
// // // //
// // // // class _OrganizerHomeState extends State<OrganizerHome> {
// // // //   final _auth = FirebaseAuth.instance;
// // // //   final _firestore = FirebaseFirestore.instance;
// // // //
// // // //   String organizerName = '';
// // // //   String profileImageUrl = '';
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadOrganizerData();
// // // //   }
// // // //
// // // //   Future<void> _loadOrganizerData() async {
// // // //     final uid = _auth.currentUser!.uid;
// // // //     final doc = await _firestore.collection('users').doc(uid).get();
// // // //     if (doc.exists) {
// // // //       final data = doc.data()!;
// // // //       setState(() {
// // // //         organizerName = data['name'] ?? '';
// // // //         profileImageUrl = data['profileImage'] ?? '';
// // // //       });
// // // //     }
// // // //   }
// // // //
// // // //   void logout(BuildContext context) async {
// // // //     await _auth.signOut();
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final organizerId = _auth.currentUser!.uid;
// // // //
// // // //     return Scaffold(
// // // //       backgroundColor: const Color(0xFFECE5DD),
// // // //       appBar: AppBar(
// // // //         elevation: 0,
// // // //         backgroundColor: const Color(0xFF075E54),
// // // //         title: const Text(
// // // //           "Organizer Dashboard",
// // // //           style: TextStyle(
// // // //             color: Colors.white,
// // // //             fontWeight: FontWeight.w600,
// // // //             fontSize: 20,
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           Padding(
// // // //             padding: const EdgeInsets.only(right: 8),
// // // //             child: IconButton(
// // // //               icon: CircleAvatar(
// // // //                 radius: 18,
// // // //                 backgroundColor: Colors.white,
// // // //                 backgroundImage: profileImageUrl.isNotEmpty
// // // //                     ? NetworkImage(profileImageUrl)
// // // //                     : null,
// // // //                 child: profileImageUrl.isEmpty
// // // //                     ? const Icon(
// // // //                   Icons.person,
// // // //                   color: Color(0xFF075E54),
// // // //                   size: 20,
// // // //                 )
// // // //                     : null,
// // // //               ),
// // // //               onPressed: () {
// // // //                 Navigator.push(
// // // //                   context,
// // // //                   MaterialPageRoute(
// // // //                     builder: (_) => const OrganizerProfileScreen(),
// // // //                   ),
// // // //                 ).then((_) => _loadOrganizerData());
// // // //               },
// // // //             ),
// // // //           ),
// // // //           Padding(
// // // //             padding: const EdgeInsets.only(right: 12),
// // // //             child: IconButton(
// // // //               icon: const Icon(
// // // //                 Icons.more_vert,
// // // //                 color: Colors.white,
// // // //               ),
// // // //               onPressed: () => logout(context),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //
// // // //       floatingActionButton: FloatingActionButton(
// // // //         backgroundColor: const Color(0xFF25D366),
// // // //         elevation: 4,
// // // //         child: const Icon(
// // // //           Icons.add,
// // // //           color: Colors.white,
// // // //           size: 28,
// // // //         ),
// // // //         onPressed: () {
// // // //           Navigator.push(
// // // //             context,
// // // //             MaterialPageRoute(
// // // //               builder: (_) => AddEventScreen(
// // // //                 organizerId: organizerId,
// // // //                 organizerName: organizerName,
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //       ),
// // // //
// // // //       body: SingleChildScrollView(
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             // Welcome Section with WhatsApp style
// // // //             Container(
// // // //               width: double.infinity,
// // // //               color: const Color(0xFF075E54),
// // // //               padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     "Welcome, $organizerName 👋",
// // // //                     style: const TextStyle(
// // // //                       fontSize: 24,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.white,
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 6),
// // // //                   const Text(
// // // //                     "Manage your events and volunteers",
// // // //                     style: TextStyle(
// // // //                       fontSize: 14,
// // // //                       color: Colors.white70,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //
// // // //             const SizedBox(height: 8),
// // // //
// // // //             // Action Cards with WhatsApp style
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(8),
// // // //               child: Row(
// // // //                 children: [
// // // //                   _optionCard(
// // // //                     title: "My Events",
// // // //                     icon: Icons.event_note,
// // // //                     color: const Color(0xFF075E54),
// // // //                     onTap: () {
// // // //                       Navigator.push(
// // // //                         context,
// // // //                         MaterialPageRoute(
// // // //                           builder: (_) => MyEventsScreen(
// // // //                             organizerId: organizerId,
// // // //                           ),
// // // //                         ),
// // // //                       );
// // // //                     },
// // // //                   ),
// // // //                   const SizedBox(width: 8),
// // // //                   _optionCard(
// // // //                     title: "Volunteers",
// // // //                     icon: Icons.groups,
// // // //                     color: const Color(0xFF25D366),
// // // //                     onTap: () {
// // // //                       // TODO: Navigate to Volunteers Screen
// // // //                     },
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _optionCard({
// // // //     required String title,
// // // //     required IconData icon,
// // // //     required Color color,
// // // //     required VoidCallback onTap,
// // // //   }) {
// // // //     return Expanded(
// // // //       child: Material(
// // // //         color: Colors.transparent,
// // // //         child: InkWell(
// // // //           onTap: onTap,
// // // //           borderRadius: BorderRadius.circular(8),
// // // //           child: Container(
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.white,
// // // //               borderRadius: BorderRadius.circular(8),
// // // //               boxShadow: [
// // // //                 BoxShadow(
// // // //                   color: Colors.black.withOpacity(0.05),
// // // //                   blurRadius: 4,
// // // //                   offset: const Offset(0, 2),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             child: Padding(
// // // //               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
// // // //               child: Column(
// // // //                 mainAxisSize: MainAxisSize.min,
// // // //                 children: [
// // // //                   Container(
// // // //                     width: 56,
// // // //                     height: 56,
// // // //                     decoration: BoxDecoration(
// // // //                       color: color,
// // // //                       shape: BoxShape.circle,
// // // //                     ),
// // // //                     child: Icon(
// // // //                       icon,
// // // //                       size: 28,
// // // //                       color: Colors.white,
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 16),
// // // //                   Text(
// // // //                     title,
// // // //                     style: const TextStyle(
// // // //                       fontSize: 16,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       color: Color(0xFF303030),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // // lib/screens/organization/organizer_home.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // import 'add_event_screen.dart';
// // // import 'my_events_screen.dart';
// // // import 'organizer_profile_screen.dart';
// // //
// // // class OrganizerHome extends StatefulWidget {
// // //   const OrganizerHome({super.key});
// // //
// // //   @override
// // //   State<OrganizerHome> createState() => _OrganizerHomeState();
// // // }
// // //
// // // class _OrganizerHomeState extends State<OrganizerHome> {
// // //   final _auth = FirebaseAuth.instance;
// // //   final _firestore = FirebaseFirestore.instance;
// // //
// // //   String organizerName = '';
// // //   String profileImageUrl = '';
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadOrganizerData();
// // //   }
// // //
// // //   Future<void> _loadOrganizerData() async {
// // //     final uid = _auth.currentUser!.uid;
// // //     final doc = await _firestore.collection('users').doc(uid).get();
// // //     if (doc.exists) {
// // //       final data = doc.data()!;
// // //       setState(() {
// // //         organizerName = data['name'] ?? '';
// // //         profileImageUrl = data['profileImage'] ?? '';
// // //       });
// // //     }
// // //   }
// // //
// // //   void logout(BuildContext context) async {
// // //     await _auth.signOut();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final organizerId = _auth.currentUser!.uid;
// // //
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF0F2F5),
// // //       body: CustomScrollView(
// // //         slivers: [
// // //           // Gradient App Bar
// // //           SliverAppBar(
// // //             expandedHeight: 200,
// // //             floating: false,
// // //             pinned: true,
// // //             elevation: 0,
// // //             flexibleSpace: Container(
// // //               decoration: const BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   begin: Alignment.topLeft,
// // //                   end: Alignment.bottomRight,
// // //                   colors: [
// // //                     Color(0xFF0099FF),
// // //                     Color(0xFF0066FF),
// // //                     Color(0xFFA033FF),
// // //                     Color(0xFFFF5280),
// // //                   ],
// // //                 ),
// // //               ),
// // //               child: FlexibleSpaceBar(
// // //                 titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
// // //                 title: const Text(
// // //                   "Dashboard",
// // //                   style: TextStyle(
// // //                     fontSize: 22,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //                 background: Stack(
// // //                   children: [
// // //                     // Decorative circles
// // //                     Positioned(
// // //                       right: -50,
// // //                       top: -50,
// // //                       child: Container(
// // //                         width: 200,
// // //                         height: 200,
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           color: Colors.white.withOpacity(0.1),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     Positioned(
// // //                       left: -30,
// // //                       bottom: -30,
// // //                       child: Container(
// // //                         width: 150,
// // //                         height: 150,
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           color: Colors.white.withOpacity(0.08),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //             actions: [
// // //               Padding(
// // //                 padding: const EdgeInsets.only(right: 8),
// // //                 child: IconButton(
// // //                   icon: Stack(
// // //                     children: [
// // //                       Container(
// // //                         width: 38,
// // //                         height: 38,
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           border: Border.all(color: Colors.white, width: 2.5),
// // //                           boxShadow: [
// // //                             BoxShadow(
// // //                               color: Colors.black.withOpacity(0.2),
// // //                               blurRadius: 8,
// // //                               offset: const Offset(0, 2),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         child: CircleAvatar(
// // //                           backgroundImage: profileImageUrl.isNotEmpty
// // //                               ? NetworkImage(profileImageUrl)
// // //                               : null,
// // //                           backgroundColor: Colors.white,
// // //                           child: profileImageUrl.isEmpty
// // //                               ? const Icon(
// // //                             Icons.person,
// // //                             color: Color(0xFF0084FF),
// // //                             size: 20,
// // //                           )
// // //                               : null,
// // //                         ),
// // //                       ),
// // //                       Positioned(
// // //                         right: 0,
// // //                         bottom: 0,
// // //                         child: Container(
// // //                           width: 12,
// // //                           height: 12,
// // //                           decoration: BoxDecoration(
// // //                             color: const Color(0xFF44BF00),
// // //                             shape: BoxShape.circle,
// // //                             border: Border.all(color: Colors.white, width: 2),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   onPressed: () {
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                         builder: (_) => const OrganizerProfileScreen(),
// // //                       ),
// // //                     ).then((_) => _loadOrganizerData());
// // //                   },
// // //                 ),
// // //               ),
// // //               IconButton(
// // //                 icon: const Icon(Icons.logout_rounded, color: Colors.white),
// // //                 onPressed: () => logout(context),
// // //               ),
// // //             ],
// // //           ),
// // //
// // //           // Content
// // //           SliverToBoxAdapter(
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(20),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   // Welcome Card with Gradient
// // //                   Container(
// // //                     width: double.infinity,
// // //                     padding: const EdgeInsets.all(24),
// // //                     decoration: BoxDecoration(
// // //                       gradient: const LinearGradient(
// // //                         begin: Alignment.topLeft,
// // //                         end: Alignment.bottomRight,
// // //                         colors: [
// // //                           Color(0xFF667EEA),
// // //                           Color(0xFF764BA2),
// // //                         ],
// // //                       ),
// // //                       borderRadius: BorderRadius.circular(24),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: const Color(0xFF667EEA).withOpacity(0.4),
// // //                           blurRadius: 20,
// // //                           offset: const Offset(0, 10),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Row(
// // //                       children: [
// // //                         Container(
// // //                           width: 70,
// // //                           height: 70,
// // //                           padding: const EdgeInsets.all(3),
// // //                           decoration: BoxDecoration(
// // //                             shape: BoxShape.circle,
// // //                             gradient: const LinearGradient(
// // //                               colors: [
// // //                                 Color(0xFFFFD700),
// // //                                 Color(0xFFFFA500),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           child: CircleAvatar(
// // //                             backgroundImage: profileImageUrl.isNotEmpty
// // //                                 ? NetworkImage(profileImageUrl)
// // //                                 : null,
// // //                             backgroundColor: Colors.white,
// // //                             child: profileImageUrl.isEmpty
// // //                                 ? Icon(
// // //                               Icons.person,
// // //                               size: 35,
// // //                               color: Colors.grey[600],
// // //                             )
// // //                                 : null,
// // //                           ),
// // //                         ),
// // //                         const SizedBox(width: 20),
// // //                         Expanded(
// // //                           child: Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               const Text(
// // //                                 "Welcome back!",
// // //                                 style: TextStyle(
// // //                                   fontSize: 15,
// // //                                   color: Colors.white70,
// // //                                   fontWeight: FontWeight.w500,
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(height: 6),
// // //                               Text(
// // //                                 organizerName.isNotEmpty
// // //                                     ? organizerName
// // //                                     : "Organizer",
// // //                                 style: const TextStyle(
// // //                                   fontSize: 24,
// // //                                   fontWeight: FontWeight.bold,
// // //                                   color: Colors.white,
// // //                                 ),
// // //                                 maxLines: 1,
// // //                                 overflow: TextOverflow.ellipsis,
// // //                               ),
// // //                               const SizedBox(height: 6),
// // //                               Container(
// // //                                 padding: const EdgeInsets.symmetric(
// // //                                   horizontal: 12,
// // //                                   vertical: 6,
// // //                                 ),
// // //                                 decoration: BoxDecoration(
// // //                                   color: Colors.white.withOpacity(0.2),
// // //                                   borderRadius: BorderRadius.circular(20),
// // //                                 ),
// // //                                 child: const Row(
// // //                                   mainAxisSize: MainAxisSize.min,
// // //                                   children: [
// // //                                     Icon(
// // //                                       Icons.star,
// // //                                       color: Color(0xFFFFD700),
// // //                                       size: 16,
// // //                                     ),
// // //                                     SizedBox(width: 4),
// // //                                     Text(
// // //                                       "Event Organizer",
// // //                                       style: TextStyle(
// // //                                         fontSize: 12,
// // //                                         color: Colors.white,
// // //                                         fontWeight: FontWeight.w600,
// // //                                       ),
// // //                                     ),
// // //                                   ],
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //
// // //                   const SizedBox(height: 30),
// // //
// // //                   const Text(
// // //                     "Quick Actions",
// // //                     style: TextStyle(
// // //                       fontSize: 20,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Color(0xFF1C1C1E),
// // //                     ),
// // //                   ),
// // //
// // //                   const SizedBox(height: 16),
// // //
// // //                   // Cards
// // //                   Row(
// // //                     children: [
// // //                       _optionCard(
// // //                         title: "My Events",
// // //                         icon: Icons.event_note,
// // //                         gradient: const LinearGradient(
// // //                           begin: Alignment.topLeft,
// // //                           end: Alignment.bottomRight,
// // //                           colors: [
// // //                             Color(0xFF0099FF),
// // //                             Color(0xFF0066FF),
// // //                           ],
// // //                         ),
// // //                         onTap: () {
// // //                           Navigator.push(
// // //                             context,
// // //                             MaterialPageRoute(
// // //                               builder: (_) => MyEventsScreen(
// // //                                 organizerId: organizerId,
// // //                               ),
// // //                             ),
// // //                           );
// // //                         },
// // //                       ),
// // //                       const SizedBox(width: 16),
// // //                       _optionCard(
// // //                         title: "Volunteers",
// // //                         icon: Icons.groups,
// // //                         gradient: const LinearGradient(
// // //                           begin: Alignment.topLeft,
// // //                           end: Alignment.bottomRight,
// // //                           colors: [
// // //                             Color(0xFFFF5280),
// // //                             Color(0xFFFF3366),
// // //                           ],
// // //                         ),
// // //                         onTap: () {
// // //                           // TODO: Navigate to Volunteers Screen
// // //                         },
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //
// // //       // Gradient FAB
// // //       floatingActionButton: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: const LinearGradient(
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //             colors: [
// // //               Color(0xFF0099FF),
// // //               Color(0xFFA033FF),
// // //             ],
// // //           ),
// // //           borderRadius: BorderRadius.circular(30),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: const Color(0xFF0084FF).withOpacity(0.5),
// // //               blurRadius: 20,
// // //               offset: const Offset(0, 10),
// // //             ),
// // //           ],
// // //         ),
// // //         child: FloatingActionButton.extended(
// // //           icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
// // //           label: const Text(
// // //             "Create Event",
// // //             style: TextStyle(
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.bold,
// // //               fontSize: 16,
// // //             ),
// // //           ),
// // //           backgroundColor: Colors.transparent,
// // //           elevation: 0,
// // //           onPressed: () {
// // //             Navigator.push(
// // //               context,
// // //               MaterialPageRoute(
// // //                 builder: (_) => AddEventScreen(
// // //                   organizerId: organizerId,
// // //                   organizerName: organizerName,
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _optionCard({
// // //     required String title,
// // //     required IconData icon,
// // //     required Gradient gradient,
// // //     required VoidCallback onTap,
// // //   }) {
// // //     return Expanded(
// // //       child: InkWell(
// // //         onTap: onTap,
// // //         borderRadius: BorderRadius.circular(20),
// // //         child: Container(
// // //           height: 160,
// // //           decoration: BoxDecoration(
// // //             gradient: gradient,
// // //             borderRadius: BorderRadius.circular(20),
// // //             boxShadow: [
// // //               BoxShadow(
// // //                 color: gradient.colors.first.withOpacity(0.4),
// // //                 blurRadius: 15,
// // //                 offset: const Offset(0, 8),
// // //               ),
// // //             ],
// // //           ),
// // //           child: Stack(
// // //             children: [
// // //               // Decorative circle
// // //               Positioned(
// // //                 right: -20,
// // //                 top: -20,
// // //                 child: Container(
// // //                   width: 100,
// // //                   height: 100,
// // //                   decoration: BoxDecoration(
// // //                     shape: BoxShape.circle,
// // //                     color: Colors.white.withOpacity(0.15),
// // //                   ),
// // //                 ),
// // //               ),
// // //               // Content
// // //               Padding(
// // //                 padding: const EdgeInsets.all(20),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     Container(
// // //                       width: 60,
// // //                       height: 60,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white.withOpacity(0.25),
// // //                         borderRadius: BorderRadius.circular(16),
// // //                       ),
// // //                       child: Icon(
// // //                         icon,
// // //                         size: 32,
// // //                         color: Colors.white,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 16),
// // //                     Text(
// // //                       title,
// // //                       style: const TextStyle(
// // //                         fontSize: 17,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.white,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // // lib/screens/organization/organizer_home.dart
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import 'add_event_screen.dart';
// // import 'my_events_screen.dart';
// // import 'organizer_profile_screen.dart';
// //
// // class OrganizerHome extends StatefulWidget {
// //   const OrganizerHome({super.key});
// //
// //   @override
// //   State<OrganizerHome> createState() => _OrganizerHomeState();
// // }
// //
// // class _OrganizerHomeState extends State<OrganizerHome> {
// //   final _auth = FirebaseAuth.instance;
// //   final _firestore = FirebaseFirestore.instance;
// //
// //   String organizerName = '';
// //   String profileImageUrl = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadOrganizerData();
// //   }
// //
// //   Future<void> _loadOrganizerData() async {
// //     final uid = _auth.currentUser!.uid;
// //     final doc = await _firestore.collection('users').doc(uid).get();
// //     if (doc.exists) {
// //       final data = doc.data()!;
// //       setState(() {
// //         organizerName = data['name'] ?? '';
// //         profileImageUrl = data['profileImage'] ?? '';
// //       });
// //     }
// //   }
// //
// //   void logout(BuildContext context) async {
// //     await _auth.signOut();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final organizerId = _auth.currentUser!.uid;
// //
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF0F2F5),
// //       body: CustomScrollView(
// //         slivers: [
// //           // Compact Gradient App Bar
// //           SliverAppBar(
// //             expandedHeight: 100,
// //             floating: false,
// //             pinned: true,
// //             elevation: 0,
// //             flexibleSpace: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                   colors: [
// //                     Color(0xFF0099FF),
// //                     Color(0xFF0066FF),
// //                     Color(0xFFA033FF),
// //                   ],
// //                 ),
// //               ),
// //               child: FlexibleSpaceBar(
// //                 titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
// //                 title: const Text(
// //                   "Dashboard",
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             actions: [
// //               Padding(
// //                 padding: const EdgeInsets.only(right: 8),
// //                 child: IconButton(
// //                   icon: Stack(
// //                     children: [
// //                       Container(
// //                         width: 36,
// //                         height: 36,
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           border: Border.all(color: Colors.white, width: 2),
// //                         ),
// //                         child: CircleAvatar(
// //                           backgroundImage: profileImageUrl.isNotEmpty
// //                               ? NetworkImage(profileImageUrl)
// //                               : null,
// //                           backgroundColor: Colors.white,
// //                           child: profileImageUrl.isEmpty
// //                               ? const Icon(
// //                             Icons.person,
// //                             color: Color(0xFF0084FF),
// //                             size: 18,
// //                           )
// //                               : null,
// //                         ),
// //                       ),
// //                       Positioned(
// //                         right: 0,
// //                         bottom: 0,
// //                         child: Container(
// //                           width: 10,
// //                           height: 10,
// //                           decoration: BoxDecoration(
// //                             color: const Color(0xFF44BF00),
// //                             shape: BoxShape.circle,
// //                             border: Border.all(color: Colors.white, width: 2),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => const OrganizerProfileScreen(),
// //                       ),
// //                     ).then((_) => _loadOrganizerData());
// //                   },
// //                 ),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.logout_rounded, color: Colors.white),
// //                 onPressed: () => logout(context),
// //               ),
// //             ],
// //           ),
// //
// //           // Content
// //           SliverToBoxAdapter(
// //             child: Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // Welcome Card with Gradient
// //                   Container(
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.all(24),
// //                     decoration: BoxDecoration(
// //                       gradient: const LinearGradient(
// //                         begin: Alignment.topLeft,
// //                         end: Alignment.bottomRight,
// //                         colors: [
// //                           Color(0xFF667EEA),
// //                           Color(0xFF764BA2),
// //                         ],
// //                       ),
// //                       borderRadius: BorderRadius.circular(24),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: const Color(0xFF667EEA).withOpacity(0.4),
// //                           blurRadius: 20,
// //                           offset: const Offset(0, 10),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Container(
// //                           width: 70,
// //                           height: 70,
// //                           padding: const EdgeInsets.all(3),
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             gradient: const LinearGradient(
// //                               colors: [
// //                                 Color(0xFFFFD700),
// //                                 Color(0xFFFFA500),
// //                               ],
// //                             ),
// //                           ),
// //                           child: CircleAvatar(
// //                             backgroundImage: profileImageUrl.isNotEmpty
// //                                 ? NetworkImage(profileImageUrl)
// //                                 : null,
// //                             backgroundColor: Colors.white,
// //                             child: profileImageUrl.isEmpty
// //                                 ? Icon(
// //                               Icons.person,
// //                               size: 35,
// //                               color: Colors.grey[600],
// //                             )
// //                                 : null,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 20),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 "Hello, ${organizerName.isNotEmpty ? organizerName : "Organizer"}! 👋",
// //                                 style: const TextStyle(
// //                                   fontSize: 20,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Colors.white,
// //                                 ),
// //                                 maxLines: 2,
// //                                 overflow: TextOverflow.ellipsis,
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Container(
// //                                 padding: const EdgeInsets.symmetric(
// //                                   horizontal: 12,
// //                                   vertical: 6,
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white.withOpacity(0.2),
// //                                   borderRadius: BorderRadius.circular(20),
// //                                 ),
// //                                 child: const Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     Icon(
// //                                       Icons.star,
// //                                       color: Color(0xFFFFD700),
// //                                       size: 14,
// //                                     ),
// //                                     SizedBox(width: 4),
// //                                     Text(
// //                                       "Event Organizer",
// //                                       style: TextStyle(
// //                                         fontSize: 11,
// //                                         color: Colors.white,
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 30),
// //
// //                   const Text(
// //                     "Quick Actions",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Color(0xFF1C1C1E),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 16),
// //
// //                   // Cards
// //                   Row(
// //                     children: [
// //                       _optionCard(
// //                         title: "My Events",
// //                         icon: Icons.event_note,
// //                         gradient: const LinearGradient(
// //                           begin: Alignment.topLeft,
// //                           end: Alignment.bottomRight,
// //                           colors: [
// //                             Color(0xFF0099FF),
// //                             Color(0xFF0066FF),
// //                           ],
// //                         ),
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (_) => MyEventsScreen(
// //                                 organizerId: organizerId,
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                       const SizedBox(width: 16),
// //                       _optionCard(
// //                         title: "Volunteers",
// //                         icon: Icons.groups,
// //                         gradient: const LinearGradient(
// //                           begin: Alignment.topLeft,
// //                           end: Alignment.bottomRight,
// //                           colors: [
// //                             Color(0xFFFF5280),
// //                             Color(0xFFFF3366),
// //                           ],
// //                         ),
// //                         onTap: () {
// //                           // TODO: Navigate to Volunteers Screen
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //
// //       // Gradient FAB
// //       floatingActionButton: Container(
// //         decoration: BoxDecoration(
// //           gradient: const LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [
// //               Color(0xFF0099FF),
// //               Color(0xFFA033FF),
// //             ],
// //           ),
// //           borderRadius: BorderRadius.circular(30),
// //           boxShadow: [
// //             BoxShadow(
// //               color: const Color(0xFF0084FF).withOpacity(0.5),
// //               blurRadius: 20,
// //               offset: const Offset(0, 10),
// //             ),
// //           ],
// //         ),
// //         child: FloatingActionButton.extended(
// //           icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
// //           label: const Text(
// //             "Create Event",
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontWeight: FontWeight.bold,
// //               fontSize: 16,
// //             ),
// //           ),
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (_) => AddEventScreen(
// //                   organizerId: organizerId,
// //                   organizerName: organizerName,
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _optionCard({
// //     required String title,
// //     required IconData icon,
// //     required Gradient gradient,
// //     required VoidCallback onTap,
// //   }) {
// //     return Expanded(
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(20),
// //         child: Container(
// //           height: 160,
// //           decoration: BoxDecoration(
// //             gradient: gradient,
// //             borderRadius: BorderRadius.circular(20),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: gradient.colors.first.withOpacity(0.4),
// //                 blurRadius: 15,
// //                 offset: const Offset(0, 8),
// //               ),
// //             ],
// //           ),
// //           child: Stack(
// //             children: [
// //               // Decorative circle
// //               Positioned(
// //                 right: -20,
// //                 top: -20,
// //                 child: Container(
// //                   width: 100,
// //                   height: 100,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: Colors.white.withOpacity(0.15),
// //                   ),
// //                 ),
// //               ),
// //               // Content
// //               Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Container(
// //                       width: 60,
// //                       height: 60,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.25),
// //                         borderRadius: BorderRadius.circular(16),
// //                       ),
// //                       child: Icon(
// //                         icon,
// //                         size: 32,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     Text(
// //                       title,
// //                       style: const TextStyle(
// //                         fontSize: 17,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // lib/screens/organization/organizer_home.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'chatroom_screen.dart';
// // import 'reports_screen.dart';
// // import 'volunteers_screen.dart';
//
// import 'add_event_screen.dart';
// import 'my_events_screen.dart';
// import 'organizer_profile_screen.dart';
//
// class OrganizerHome extends StatefulWidget {
//   const OrganizerHome({super.key});
//
//   @override
//   State<OrganizerHome> createState() => _OrganizerHomeState();
// }
//
// class _OrganizerHomeState extends State<OrganizerHome> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   String organizerName = '';
//   String profileImageUrl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadOrganizerData();
//   }
//
//   Future<void> _loadOrganizerData() async {
//     final uid = _auth.currentUser!.uid;
//     final doc = await _firestore.collection('users').doc(uid).get();
//     if (doc.exists) {
//       final data = doc.data()!;
//       setState(() {
//         organizerName = data['name'] ?? '';
//         profileImageUrl = data['profileImage'] ?? '';
//       });
//     }
//   }
//
//   void logout(BuildContext context) async {
//     await _auth.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final organizerId = _auth.currentUser!.uid;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F2F5),
//       body: CustomScrollView(
//         slivers: [
//           // App Bar
//           SliverAppBar(
//             expandedHeight: 100,
//             floating: false,
//             pinned: true,
//             elevation: 0,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFF0099FF),
//                     Color(0xFF0066FF),
//                     Color(0xFFA033FF),
//                   ],
//                 ),
//               ),
//               child: FlexibleSpaceBar(
//                 titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
//                 title: const Text(
//                   "Dashboard",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: IconButton(
//                   icon: Stack(
//                     children: [
//                       Container(
//                         width: 36,
//                         height: 36,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                         child: CircleAvatar(
//                           backgroundImage: profileImageUrl.isNotEmpty
//                               ? NetworkImage(profileImageUrl)
//                               : null,
//                           backgroundColor: Colors.white,
//                           child: profileImageUrl.isEmpty
//                               ? const Icon(
//                             Icons.person,
//                             color: Color(0xFF0084FF),
//                             size: 18,
//                           )
//                               : null,
//                         ),
//                       ),
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         child: Container(
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF44BF00),
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 2),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const OrganizerProfileScreen(),
//                       ),
//                     ).then((_) => _loadOrganizerData());
//                   },
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.logout_rounded, color: Colors.white),
//                 onPressed: () => logout(context),
//               ),
//             ],
//           ),
//
//           // Content
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Welcome Card
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color(0xFF667EEA),
//                           Color(0xFF764BA2),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFF667EEA).withOpacity(0.4),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 70,
//                           height: 70,
//                           padding: const EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xFFFFD700),
//                                 Color(0xFFFFA500),
//                               ],
//                             ),
//                           ),
//                           child: CircleAvatar(
//                             backgroundImage: profileImageUrl.isNotEmpty
//                                 ? NetworkImage(profileImageUrl)
//                                 : null,
//                             backgroundColor: Colors.white,
//                             child: profileImageUrl.isEmpty
//                                 ? Icon(
//                               Icons.person,
//                               size: 35,
//                               color: Colors.grey[600],
//                             )
//                                 : null,
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Hello, ${organizerName.isNotEmpty ? organizerName : "Organizer"}! 👋",
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: const Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: Color(0xFFFFD700),
//                                       size: 14,
//                                     ),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       "Event Organizer",
//                                       style: TextStyle(
//                                         fontSize: 11,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   // 4 Option Cards Grid
//                   Wrap(
//                     spacing: 16,
//                     runSpacing: 16,
//                     children: [
//                       _optionCard(
//                         title: "My Events",
//                         icon: Icons.event_note,
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFF0099FF),
//                             Color(0xFF0066FF),
//                           ],
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => MyEventsScreen(
//                                 organizerId: organizerId,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       _optionCard(
//                         title: "Volunteers",
//                         icon: Icons.groups,
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFFFF5280),
//                             Color(0xFFFF3366),
//                           ],
//                         ),
//                         onTap: () {
//                           // TODO: Navigate to Volunteers Screen
//                         },
//                       ),
//                       _optionCard(
//                         title: "Chatroom",
//                         icon: Icons.chat_bubble_rounded,
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFF8A2BE2),
//                             Color(0xFF6A0DAD),
//                           ],
//                         ),
//                         onTap: () {
//                           // TODO: Navigate to Chatroom Screen
//                         },
//                       ),
//                       _optionCard(
//                         title: "Reports",
//                         icon: Icons.bar_chart_rounded,
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFF00C6FF),
//                             Color(0xFF0072FF),
//                           ],
//                         ),
//                         onTap: () {
//                           // TODO: Navigate to Reports Screen
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // FAB
//       floatingActionButton: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0099FF),
//               Color(0xFFA033FF),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF0084FF).withOpacity(0.5),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: FloatingActionButton.extended(
//           icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
//           label: const Text(
//             "Create Event",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => AddEventScreen(
//                   organizerId: organizerId,
//                   organizerName: organizerName,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _optionCard({
//     required String title,
//     required IconData icon,
//     required Gradient gradient,
//     required VoidCallback onTap,
//   }) {
//     return SizedBox(
//       width: (MediaQuery.of(context).size.width - 56) / 2,
//       height: 160,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: gradient.colors.first.withOpacity(0.4),
//                 blurRadius: 15,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               // Decorative circle
//               Positioned(
//                 right: -20,
//                 top: -20,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.15),
//                   ),
//                 ),
//               ),
//               // Content
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.25),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Icon(
//                         icon,
//                         size: 32,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
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
import 'chatroom_screen.dart';
import 'reports_screen.dart';

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
      backgroundColor: const Color(0xFFF0F2F5),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0099FF),
                    Color(0xFF0066FF),
                    Color(0xFFA033FF),
                  ],
                ),
              ),
              child: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Stack(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : null,
                          backgroundColor: Colors.white,
                          child: profileImageUrl.isEmpty
                              ? const Icon(
                            Icons.person,
                            color: Color(0xFF0084FF),
                            size: 18,
                          )
                              : null,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF44BF00),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrganizerProfileScreen(),
                      ),
                    ).then((_) => _loadOrganizerData());
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                onPressed: () => logout(context),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF667EEA),
                          Color(0xFF764BA2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF667EEA).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFD700),
                                Color(0xFFFFA500),
                              ],
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: profileImageUrl.isNotEmpty
                                ? NetworkImage(profileImageUrl)
                                : null,
                            backgroundColor: Colors.white,
                            child: profileImageUrl.isEmpty
                                ? Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.grey[600],
                            )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, ${organizerName.isNotEmpty ? organizerName : "Organizer"}! 👋",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFFFD700),
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Event Organizer",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 4 Option Cards Grid
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _optionCard(
                        title: "My Events",
                        icon: Icons.event_note,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0099FF),
                            Color(0xFF0066FF),
                          ],
                        ),
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
                      _optionCard(
                        title: "Volunteers",
                        icon: Icons.groups,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFF5280),
                            Color(0xFFFF3366),
                          ],
                        ),
                        onTap: () {
                          // TODO: Navigate to Volunteers Screen
                        },
                      ),
                      _optionCard(
                        title: "Chatroom",
                        icon: Icons.chat_bubble_rounded,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8A2BE2),
                            Color(0xFF6A0DAD),
                          ],
                        ),
                        onTap: () async {
                          // Navigate to the first event's chat for now
                          final eventSnapshot = await FirebaseFirestore.instance
                              .collection('events')
                              .where('organizerId', isEqualTo: organizerId)
                              .limit(1)
                              .get();

                          if (eventSnapshot.docs.isNotEmpty) {
                            final event = eventSnapshot.docs.first;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatroomScreen(
                                  eventId: event.id,
                                  eventName: event['name'] ?? "Event Chat",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("No events available for chat."),
                              ),
                            );
                          }
                        },
                      ),
                      _optionCard(
                        title: "Reports",
                        icon: Icons.bar_chart_rounded,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF00C6FF),
                            Color(0xFF0072FF),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReportsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // FAB
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0099FF),
              Color(0xFFA033FF),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0084FF).withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
          label: const Text(
            "Create Event",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
      ),
    );
  }

  Widget _optionCard({
    required String title,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      height: 160,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        icon,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
