// // // //
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
// // // //       backgroundColor: const Color(0xFFF0F2F5),
// // // //       body: CustomScrollView(
// // // //         slivers: [
// // // //           // Compact Gradient App Bar
// // // //           SliverAppBar(
// // // //             expandedHeight: 100,
// // // //             floating: false,
// // // //             pinned: true,
// // // //             elevation: 0,
// // // //             flexibleSpace: Container(
// // // //               decoration: const BoxDecoration(
// // // //                 gradient: LinearGradient(
// // // //                   begin: Alignment.topLeft,
// // // //                   end: Alignment.bottomRight,
// // // //                   colors: [
// // // //                     Color(0xFF0099FF),
// // // //                     Color(0xFF0066FF),
// // // //                     Color(0xFFA033FF),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               child: FlexibleSpaceBar(
// // // //                 titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
// // // //                 title: const Text(
// // // //                   "Dashboard",
// // // //                   style: TextStyle(
// // // //                     fontSize: 20,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     color: Colors.white,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             actions: [
// // // //               Padding(
// // // //                 padding: const EdgeInsets.only(right: 8),
// // // //                 child: IconButton(
// // // //                   icon: Stack(
// // // //                     children: [
// // // //                       Container(
// // // //                         width: 36,
// // // //                         height: 36,
// // // //                         decoration: BoxDecoration(
// // // //                           shape: BoxShape.circle,
// // // //                           border: Border.all(color: Colors.white, width: 2),
// // // //                         ),
// // // //                         child: CircleAvatar(
// // // //                           backgroundImage: profileImageUrl.isNotEmpty
// // // //                               ? NetworkImage(profileImageUrl)
// // // //                               : null,
// // // //                           backgroundColor: Colors.white,
// // // //                           child: profileImageUrl.isEmpty
// // // //                               ? const Icon(
// // // //                             Icons.person,
// // // //                             color: Color(0xFF0084FF),
// // // //                             size: 18,
// // // //                           )
// // // //                               : null,
// // // //                         ),
// // // //                       ),
// // // //                       Positioned(
// // // //                         right: 0,
// // // //                         bottom: 0,
// // // //                         child: Container(
// // // //                           width: 10,
// // // //                           height: 10,
// // // //                           decoration: BoxDecoration(
// // // //                             color: const Color(0xFF44BF00),
// // // //                             shape: BoxShape.circle,
// // // //                             border: Border.all(color: Colors.white, width: 2),
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   onPressed: () {
// // // //                     Navigator.push(
// // // //                       context,
// // // //                       MaterialPageRoute(
// // // //                         builder: (_) => const OrganizerProfileScreen(),
// // // //                       ),
// // // //                     ).then((_) => _loadOrganizerData());
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //               IconButton(
// // // //                 icon: const Icon(Icons.logout_rounded, color: Colors.white),
// // // //                 onPressed: () => logout(context),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //
// // // //           // Content
// // // //           SliverToBoxAdapter(
// // // //             child: Padding(
// // // //               padding: const EdgeInsets.all(20),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   // Welcome Card with Gradient
// // // //                   Container(
// // // //                     width: double.infinity,
// // // //                     padding: const EdgeInsets.all(24),
// // // //                     decoration: BoxDecoration(
// // // //                       gradient: const LinearGradient(
// // // //                         begin: Alignment.topLeft,
// // // //                         end: Alignment.bottomRight,
// // // //                         colors: [
// // // //                           Color(0xFF667EEA),
// // // //                           Color(0xFF764BA2),
// // // //                         ],
// // // //                       ),
// // // //                       borderRadius: BorderRadius.circular(24),
// // // //                       boxShadow: [
// // // //                         BoxShadow(
// // // //                           color: const Color(0xFF667EEA).withOpacity(0.4),
// // // //                           blurRadius: 20,
// // // //                           offset: const Offset(0, 10),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     child: Row(
// // // //                       children: [
// // // //                         Container(
// // // //                           width: 70,
// // // //                           height: 70,
// // // //                           padding: const EdgeInsets.all(3),
// // // //                           decoration: BoxDecoration(
// // // //                             shape: BoxShape.circle,
// // // //                             gradient: const LinearGradient(
// // // //                               colors: [
// // // //                                 Color(0xFFFFD700),
// // // //                                 Color(0xFFFFA500),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                           child: CircleAvatar(
// // // //                             backgroundImage: profileImageUrl.isNotEmpty
// // // //                                 ? NetworkImage(profileImageUrl)
// // // //                                 : null,
// // // //                             backgroundColor: Colors.white,
// // // //                             child: profileImageUrl.isEmpty
// // // //                                 ? Icon(
// // // //                               Icons.person,
// // // //                               size: 35,
// // // //                               color: Colors.grey[600],
// // // //                             )
// // // //                                 : null,
// // // //                           ),
// // // //                         ),
// // // //                         const SizedBox(width: 20),
// // // //                         Expanded(
// // // //                           child: Column(
// // // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // // //                             children: [
// // // //                               Text(
// // // //                                 "Hello, ${organizerName.isNotEmpty ? organizerName : "Organizer"}! 👋",
// // // //                                 style: const TextStyle(
// // // //                                   fontSize: 20,
// // // //                                   fontWeight: FontWeight.bold,
// // // //                                   color: Colors.white,
// // // //                                 ),
// // // //                                 maxLines: 2,
// // // //                                 overflow: TextOverflow.ellipsis,
// // // //                               ),
// // // //                               const SizedBox(height: 8),
// // // //                               Container(
// // // //                                 padding: const EdgeInsets.symmetric(
// // // //                                   horizontal: 12,
// // // //                                   vertical: 6,
// // // //                                 ),
// // // //                                 decoration: BoxDecoration(
// // // //                                   color: Colors.white.withOpacity(0.2),
// // // //                                   borderRadius: BorderRadius.circular(20),
// // // //                                 ),
// // // //                                 child: const Row(
// // // //                                   mainAxisSize: MainAxisSize.min,
// // // //                                   children: [
// // // //                                     Icon(
// // // //                                       Icons.star,
// // // //                                       color: Color(0xFFFFD700),
// // // //                                       size: 14,
// // // //                                     ),
// // // //                                     SizedBox(width: 4),
// // // //                                     Text(
// // // //                                       "Event Organizer",
// // // //                                       style: TextStyle(
// // // //                                         fontSize: 11,
// // // //                                         color: Colors.white,
// // // //                                         fontWeight: FontWeight.w600,
// // // //                                       ),
// // // //                                     ),
// // // //                                   ],
// // // //                                 ),
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //
// // // //                   const SizedBox(height: 30),
// // // //
// // // //                   const Text(
// // // //                     "Quick Actions",
// // // //                     style: TextStyle(
// // // //                       fontSize: 20,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Color(0xFF1C1C1E),
// // // //                     ),
// // // //                   ),
// // // //
// // // //                   const SizedBox(height: 16),
// // // //
// // // //                   // Cards
// // // //                   Row(
// // // //                     children: [
// // // //                       _optionCard(
// // // //                         title: "My Events",
// // // //                         icon: Icons.event_note,
// // // //                         gradient: const LinearGradient(
// // // //                           begin: Alignment.topLeft,
// // // //                           end: Alignment.bottomRight,
// // // //                           colors: [
// // // //                             Color(0xFF0099FF),
// // // //                             Color(0xFF0066FF),
// // // //                           ],
// // // //                         ),
// // // //                         onTap: () {
// // // //                           Navigator.push(
// // // //                             context,
// // // //                             MaterialPageRoute(
// // // //                               builder: (_) => MyEventsScreen(
// // // //                                 organizerId: organizerId,
// // // //                               ),
// // // //                             ),
// // // //                           );
// // // //                         },
// // // //                       ),
// // // //                       const SizedBox(width: 16),
// // // //                       _optionCard(
// // // //                         title: "Volunteers",
// // // //                         icon: Icons.groups,
// // // //                         gradient: const LinearGradient(
// // // //                           begin: Alignment.topLeft,
// // // //                           end: Alignment.bottomRight,
// // // //                           colors: [
// // // //                             Color(0xFFFF5280),
// // // //                             Color(0xFFFF3366),
// // // //                           ],
// // // //                         ),
// // // //                         onTap: () {
// // // //                           // TODO: Navigate to Volunteers Screen
// // // //                         },
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //
// // // //       // Gradient FAB
// // // //       floatingActionButton: Container(
// // // //         decoration: BoxDecoration(
// // // //           gradient: const LinearGradient(
// // // //             begin: Alignment.topLeft,
// // // //             end: Alignment.bottomRight,
// // // //             colors: [
// // // //               Color(0xFF0099FF),
// // // //               Color(0xFFA033FF),
// // // //             ],
// // // //           ),
// // // //           borderRadius: BorderRadius.circular(30),
// // // //           boxShadow: [
// // // //             BoxShadow(
// // // //               color: const Color(0xFF0084FF).withOpacity(0.5),
// // // //               blurRadius: 20,
// // // //               offset: const Offset(0, 10),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //         child: FloatingActionButton.extended(
// // // //           icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
// // // //           label: const Text(
// // // //             "Create Event",
// // // //             style: TextStyle(
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.bold,
// // // //               fontSize: 16,
// // // //             ),
// // // //           ),
// // // //           backgroundColor: Colors.transparent,
// // // //           elevation: 0,
// // // //           onPressed: () {
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(
// // // //                 builder: (_) => AddEventScreen(
// // // //                   organizerId: organizerId,
// // // //                   organizerName: organizerName,
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           },
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _optionCard({
// // // //     required String title,
// // // //     required IconData icon,
// // // //     required Gradient gradient,
// // // //     required VoidCallback onTap,
// // // //   }) {
// // // //     return Expanded(
// // // //       child: InkWell(
// // // //         onTap: onTap,
// // // //         borderRadius: BorderRadius.circular(20),
// // // //         child: Container(
// // // //           height: 160,
// // // //           decoration: BoxDecoration(
// // // //             gradient: gradient,
// // // //             borderRadius: BorderRadius.circular(20),
// // // //             boxShadow: [
// // // //               BoxShadow(
// // // //                 color: gradient.colors.first.withOpacity(0.4),
// // // //                 blurRadius: 15,
// // // //                 offset: const Offset(0, 8),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           child: Stack(
// // // //             children: [
// // // //               // Decorative circle
// // // //               Positioned(
// // // //                 right: -20,
// // // //                 top: -20,
// // // //                 child: Container(
// // // //                   width: 100,
// // // //                   height: 100,
// // // //                   decoration: BoxDecoration(
// // // //                     shape: BoxShape.circle,
// // // //                     color: Colors.white.withOpacity(0.15),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               // Content
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(20),
// // // //                 child: Column(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     Container(
// // // //                       width: 60,
// // // //                       height: 60,
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white.withOpacity(0.25),
// // // //                         borderRadius: BorderRadius.circular(16),
// // // //                       ),
// // // //                       child: Icon(
// // // //                         icon,
// // // //                         size: 32,
// // // //                         color: Colors.white,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 16),
// // // //                     Text(
// // // //                       title,
// // // //                       style: const TextStyle(
// // // //                         fontSize: 17,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         color: Colors.white,
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ],
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
// // // import 'chatroom_screen.dart';
// // // // import 'reports_screen.dart';
// // // // import 'volunteers_screen.dart';
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
// // //           // App Bar
// // //           SliverAppBar(
// // //             expandedHeight: 100,
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
// // //                   ],
// // //                 ),
// // //               ),
// // //               child: FlexibleSpaceBar(
// // //                 titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
// // //                 title: const Text(
// // //                   "Dashboard",
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
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
// // //                         width: 36,
// // //                         height: 36,
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           border: Border.all(color: Colors.white, width: 2),
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
// // //                             size: 18,
// // //                           )
// // //                               : null,
// // //                         ),
// // //                       ),
// // //                       Positioned(
// // //                         right: 0,
// // //                         bottom: 0,
// // //                         child: Container(
// // //                           width: 10,
// // //                           height: 10,
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
// // //                   // Welcome Card
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
// // //                               Text(
// // //                                 "Hello, ${organizerName.isNotEmpty ? organizerName : "Organizer"}! 👋",
// // //                                 style: const TextStyle(
// // //                                   fontSize: 20,
// // //                                   fontWeight: FontWeight.bold,
// // //                                   color: Colors.white,
// // //                                 ),
// // //                                 maxLines: 2,
// // //                                 overflow: TextOverflow.ellipsis,
// // //                               ),
// // //                               const SizedBox(height: 8),
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
// // //                                       size: 14,
// // //                                     ),
// // //                                     SizedBox(width: 4),
// // //                                     Text(
// // //                                       "Event Organizer",
// // //                                       style: TextStyle(
// // //                                         fontSize: 11,
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
// // //                   // 4 Option Cards Grid
// // //                   Wrap(
// // //                     spacing: 16,
// // //                     runSpacing: 16,
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
// // //                       _optionCard(
// // //                         title: "Chatroom",
// // //                         icon: Icons.chat_bubble_rounded,
// // //                         gradient: const LinearGradient(
// // //                           begin: Alignment.topLeft,
// // //                           end: Alignment.bottomRight,
// // //                           colors: [
// // //                             Color(0xFF8A2BE2),
// // //                             Color(0xFF6A0DAD),
// // //                           ],
// // //                         ),
// // //                         onTap: () {
// // //                           // TODO: Navigate to Chatroom Screen
// // //                         },
// // //                       ),
// // //                       _optionCard(
// // //                         title: "Reports",
// // //                         icon: Icons.bar_chart_rounded,
// // //                         gradient: const LinearGradient(
// // //                           begin: Alignment.topLeft,
// // //                           end: Alignment.bottomRight,
// // //                           colors: [
// // //                             Color(0xFF00C6FF),
// // //                             Color(0xFF0072FF),
// // //                           ],
// // //                         ),
// // //                         onTap: () {
// // //                           // TODO: Navigate to Reports Screen
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
// // //       // FAB
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
// // //     return SizedBox(
// // //       width: (MediaQuery.of(context).size.width - 56) / 2,
// // //       height: 160,
// // //       child: InkWell(
// // //         onTap: onTap,
// // //         borderRadius: BorderRadius.circular(20),
// // //         child: Container(
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
// // import 'chatroom_screen.dart';
// // import 'reports_screen.dart';
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
// //           // App Bar
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
// //                   // Welcome Card
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
// //                   // 4 Option Cards Grid
// //                   Wrap(
// //                     spacing: 16,
// //                     runSpacing: 16,
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
// //                       _optionCard(
// //                         title: "Chatroom",
// //                         icon: Icons.chat_bubble_rounded,
// //                         gradient: const LinearGradient(
// //                           begin: Alignment.topLeft,
// //                           end: Alignment.bottomRight,
// //                           colors: [
// //                             Color(0xFF8A2BE2),
// //                             Color(0xFF6A0DAD),
// //                           ],
// //                         ),
// //                         onTap: () async {
// //                           // Navigate to the first event's chat for now
// //                           final eventSnapshot = await FirebaseFirestore.instance
// //                               .collection('events')
// //                               .where('organizerId', isEqualTo: organizerId)
// //                               .limit(1)
// //                               .get();
// //
// //                           if (eventSnapshot.docs.isNotEmpty) {
// //                             final event = eventSnapshot.docs.first;
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (_) => ChatroomScreen(
// //                                   eventId: event.id,
// //                                   eventName: event['name'] ?? "Event Chat",
// //                                 ),
// //                               ),
// //                             );
// //                           } else {
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                 content: Text("No events available for chat."),
// //                               ),
// //                             );
// //                           }
// //                         },
// //                       ),
// //                       _optionCard(
// //                         title: "Reports",
// //                         icon: Icons.bar_chart_rounded,
// //                         gradient: const LinearGradient(
// //                           begin: Alignment.topLeft,
// //                           end: Alignment.bottomRight,
// //                           colors: [
// //                             Color(0xFF00C6FF),
// //                             Color(0xFF0072FF),
// //                           ],
// //                         ),
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (_) => const ReportsScreen(),
// //                             ),
// //                           );
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
// //       // FAB
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
// //     return SizedBox(
// //       width: (MediaQuery.of(context).size.width - 56) / 2,
// //       height: 160,
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(20),
// //         child: Container(
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
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'add_event_screen.dart';
// import 'my_events_screen.dart';
// import 'organizer_profile_screen.dart';
// import 'chatroom_screen.dart';
// import 'reports_screen.dart';
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
//   int totalEvents = 0;
//   int activeEvents = 0;
//   int totalVolunteers = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadOrganizerData();
//     _loadStats();
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
//   Future<void> _loadStats() async {
//     final uid = _auth.currentUser!.uid;
//
//     // Load total events
//     final eventsSnapshot = await _firestore
//         .collection('events')
//         .where('organizerId', isEqualTo: uid)
//         .get();
//
//     // Count active events (you can customize this logic)
//     final now = DateTime.now();
//     int active = 0;
//     for (var doc in eventsSnapshot.docs) {
//       // Assuming events have a 'date' field
//       if (doc.data().containsKey('date')) {
//         // Add logic to check if event is active
//         active++;
//       }
//     }
//
//     setState(() {
//       totalEvents = eventsSnapshot.docs.length;
//       activeEvents = active;
//       // You can add volunteer count logic here
//       totalVolunteers = 0;
//     });
//   }
//
//   void logout(BuildContext context) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Logout',
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           content: const Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               style: TextButton.styleFrom(
//                 foregroundColor: const Color(0xFFEF4444),
//               ),
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (confirm == true) {
//       await _auth.signOut();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final organizerId = _auth.currentUser!.uid;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF4F46E5),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.dashboard,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               "Dashboard",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Color(0xFF6B7280)),
//             onPressed: () => logout(context),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await _loadOrganizerData();
//           await _loadStats();
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Section
//               Container(
//                 width: double.infinity,
//                 color: Colors.white,
//                 padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Hello, ${organizerName.isNotEmpty ? organizerName.split(' ')[0] : 'there'}!",
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF111827),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "Here's what's happening with your events",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Stats Cards
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: _statCard(
//                         title: "Total Events",
//                         value: totalEvents.toString(),
//                         icon: Icons.event,
//                         color: const Color(0xFF4F46E5),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _statCard(
//                         title: "Active",
//                         value: activeEvents.toString(),
//                         icon: Icons.trending_up,
//                         color: const Color(0xFF10B981),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _statCard(
//                         title: "Volunteers",
//                         value: totalVolunteers.toString(),
//                         icon: Icons.people,
//                         color: const Color(0xFFF59E0B),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Quick Actions Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Quick Actions",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF111827),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "See All",
//                         style: TextStyle(
//                           color: Color(0xFF4F46E5),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               // Action Cards
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     _actionCard(
//                       title: "My Events",
//                       subtitle: "Manage all your events",
//                       icon: Icons.event_note,
//                       iconColor: const Color(0xFF4F46E5),
//                       iconBg: const Color(0xFFEEF2FF),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => MyEventsScreen(organizerId: organizerId),
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     _actionCard(
//                       title: "Volunteers",
//                       subtitle: "View and manage volunteers",
//                       icon: Icons.groups,
//                       iconColor: const Color(0xFFEC4899),
//                       iconBg: const Color(0xFFFCE7F3),
//                       onTap: () {
//                         // TODO: Navigate to Volunteers Screen
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     _actionCard(
//                       title: "Chatroom",
//                       subtitle: "Communicate with your team",
//                       icon: Icons.chat_bubble,
//                       iconColor: const Color(0xFF06B6D4),
//                       iconBg: const Color(0xFFCFFAFE),
//                       onTap: () async {
//                         final eventSnapshot = await FirebaseFirestore.instance
//                             .collection('events')
//                             .where('organizerId', isEqualTo: organizerId)
//                             .limit(1)
//                             .get();
//
//                         if (eventSnapshot.docs.isNotEmpty) {
//                           final event = eventSnapshot.docs.first;
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => ChatroomScreen(
//                                 eventId: event.id,
//                                 eventName: event['name'] ?? "Event Chat",
//                               ),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("No events available for chat."),
//                               behavior: SnackBarBehavior.floating,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     _actionCard(
//                       title: "Reports",
//                       subtitle: "View analytics and insights",
//                       icon: Icons.bar_chart,
//                       iconColor: const Color(0xFFF59E0B),
//                       iconBg: const Color(0xFFFEF3C7),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const ReportsScreen()),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//
//       // Bottom Navigation Bar
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _navItem(Icons.home, "Home", true, () {}),
//                 _navItem(Icons.notifications_outlined, "Notifications", false, () {
//                   // TODO: Navigate to Notifications Screen
//                 }),
//                 _navItem(Icons.person_outline, "Profile", false, () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OrganizerProfileScreen()),
//                   ).then((_) => _loadOrganizerData());
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//       // FAB for adding events
//       floatingActionButton: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF4F46E5).withOpacity(0.3),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: FloatingActionButton(
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
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           child: const Icon(Icons.add, color: Colors.white, size: 28),
//         ),
//       ),
//     );
//   }
//
//   Widget _statCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 20),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF111827),
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _actionCard({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color iconColor,
//     required Color iconBg,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: const Color(0xFFE5E7EB)),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: iconBg,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, color: iconColor, size: 24),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF111827),
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: Color(0xFF9CA3AF),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _navItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
//             size: 24,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
//               fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  int totalEvents = 0;
  int activeEvents = 0;
  int totalVolunteers = 0;

  @override
  void initState() {
    super.initState();
    _loadOrganizerData();
    _loadStats();
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

  Future<void> _loadStats() async {
    final uid = _auth.currentUser!.uid;

    // Load total events
    final eventsSnapshot = await _firestore
        .collection('events')
        .where('organizerId', isEqualTo: uid)
        .get();

    // Count active events (you can customize this logic)
    final now = DateTime.now();
    int active = 0;
    for (var doc in eventsSnapshot.docs) {
      if (doc.data().containsKey('date')) {
        // Add logic to check if event is active
        active++;
      }
    }

    setState(() {
      totalEvents = eventsSnapshot.docs.length;
      activeEvents = active;
      totalVolunteers = 0; // Add logic for volunteers if needed
    });
  }

  void logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _auth.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final organizerId = _auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.dashboard,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF6B7280)),
            onPressed: () => logout(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadOrganizerData();
          await _loadStats();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ${organizerName.isNotEmpty ? organizerName.split(' ')[0] : 'there'}!",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Here's what's happening with your events",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        title: "Total Events",
                        value: totalEvents.toString(),
                        icon: Icons.event,
                        color: const Color(0xFF4F46E5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                        title: "Active",
                        value: activeEvents.toString(),
                        icon: Icons.trending_up,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                        title: "Volunteers",
                        value: totalVolunteers.toString(),
                        icon: Icons.people,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ),

              // Quick Actions Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Action Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _actionCard(
                      title: "My Events",
                      subtitle: "Manage all your events",
                      icon: Icons.event_note,
                      iconColor: const Color(0xFF4F46E5),
                      iconBg: const Color(0xFFEEF2FF),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyEventsScreen(organizerId: organizerId),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _actionCard(
                      title: "Volunteers",
                      subtitle: "View and manage volunteers",
                      icon: Icons.groups,
                      iconColor: const Color(0xFFEC4899),
                      iconBg: const Color(0xFFFCE7F3),
                      onTap: () {
                        // TODO: Navigate to Volunteers Screen
                      },
                    ),
                    const SizedBox(height: 12),
                    _actionCard(
                      title: "Chatroom",
                      subtitle: "Communicate with your team",
                      icon: Icons.chat_bubble,
                      iconColor: const Color(0xFF06B6D4),
                      iconBg: const Color(0xFFCFFAFE),
                      onTap: () async {
                        final eventSnapshot = await FirebaseFirestore.instance
                            .collection('events')
                            .where('organizerId', isEqualTo: organizerId)
                            .limit(1)
                            .get();

                        if (eventSnapshot.docs.isNotEmpty) {
                          final event = eventSnapshot.docs.first;
                          final eventData = event.data() as Map<String, dynamic>; // <-- Fixed here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatroomScreen(
                                eventId: event.id,
                                eventName: eventData['name'] ?? "Event Chat",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No events available for chat."),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _actionCard(
                      title: "Reports",
                      subtitle: "View analytics and insights",
                      icon: Icons.bar_chart,
                      iconColor: const Color(0xFFF59E0B),
                      iconBg: const Color(0xFFFEF3C7),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ReportsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home, "Home", true, () {}),
                _navItem(Icons.notifications_outlined, "Notifications", false, () {}),
                _navItem(Icons.person_outline, "Profile", false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrganizerProfileScreen()),
                  ).then((_) => _loadOrganizerData());
                }),
              ],
            ),
          ),
        ),
      ),

      // FAB for adding events
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4F46E5).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
