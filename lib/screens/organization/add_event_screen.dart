// // // import 'package:flutter/material.dart';
// // // import '../../services/firestore_service.dart';
// // //
// // // class AddEventScreen extends StatefulWidget {
// // //   final String organizerId;
// // //   final String organizerName;
// // //
// // //   const AddEventScreen({
// // //     super.key,
// // //     required this.organizerId,
// // //     required this.organizerName,
// // //   });
// // //
// // //   @override
// // //   State<AddEventScreen> createState() => _AddEventScreenState();
// // // }
// // //
// // // class _AddEventScreenState extends State<AddEventScreen> {
// // //   final _titleController = TextEditingController();
// // //   final _descController = TextEditingController();
// // //   final _locationController = TextEditingController();
// // //   DateTime? _selectedDate;
// // //   bool _loading = false;
// // //
// // //   final FirestoreService _firestoreService = FirestoreService();
// // //
// // //   Future<void> _pickDate() async {
// // //     final date = await showDatePicker(
// // //       context: context,
// // //       initialDate: DateTime.now(),
// // //       firstDate: DateTime.now(),
// // //       lastDate: DateTime(2100),
// // //     );
// // //     if (date != null) setState(() => _selectedDate = date);
// // //   }
// // //
// // //   Future<void> _submit() async {
// // //     if (_titleController.text.isEmpty ||
// // //         _descController.text.isEmpty ||
// // //         _locationController.text.isEmpty ||
// // //         _selectedDate == null) {
// // //       ScaffoldMessenger.of(context)
// // //           .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
// // //       return;
// // //     }
// // //
// // //     setState(() => _loading = true);
// // //
// // //     try {
// // //       await _firestoreService.createEvent(
// // //         title: _titleController.text.trim(),
// // //         description: _descController.text.trim(),
// // //         location: _locationController.text.trim(),
// // //         date: _selectedDate!,
// // //         organizerId: widget.organizerId,
// // //         organizerName: widget.organizerName,
// // //       );
// // //
// // //       ScaffoldMessenger.of(context)
// // //           .showSnackBar(const SnackBar(content: Text("Event added successfully")));
// // //       Navigator.pop(context);
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context)
// // //           .showSnackBar(SnackBar(content: Text("Error: $e")));
// // //     } finally {
// // //       setState(() => _loading = false);
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Add Event")),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           children: [
// // //             TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
// // //             TextField(controller: _descController, decoration: const InputDecoration(labelText: "Description")),
// // //             TextField(controller: _locationController, decoration: const InputDecoration(labelText: "Location")),
// // //             const SizedBox(height: 16),
// // //             Row(
// // //               children: [
// // //                 Text(_selectedDate == null ? "Pick Date" : _selectedDate!.toLocal().toString().split(' ')[0]),
// // //                 const SizedBox(width: 10),
// // //                 ElevatedButton(onPressed: _pickDate, child: const Text("Select Date")),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 20),
// // //             _loading
// // //                 ? const CircularProgressIndicator()
// // //                 : SizedBox(
// // //               width: double.infinity,
// // //               child: ElevatedButton(onPressed: _submit, child: const Text("Add Event")),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import '../../services/firestore_service.dart';
// //
// // class AddEventScreen extends StatefulWidget {
// //   final String organizerId;
// //   final String organizerName;
// //
// //   const AddEventScreen({
// //     super.key,
// //     required this.organizerId,
// //     required this.organizerName,
// //   });
// //
// //   @override
// //   State<AddEventScreen> createState() => _AddEventScreenState();
// // }
// //
// // class _AddEventScreenState extends State<AddEventScreen> {
// //   final _titleController = TextEditingController();
// //   final _descController = TextEditingController();
// //   final _locationController = TextEditingController();
// //   DateTime? _selectedDate;
// //   bool _loading = false;
// //
// //   final FirestoreService _firestoreService = FirestoreService();
// //
// //   Future<void> _pickDate() async {
// //     final date = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now(),
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime(2100),
// //     );
// //     if (date != null) setState(() => _selectedDate = date);
// //   }
// //
// //   Future<void> _submit() async {
// //     if (_titleController.text.isEmpty ||
// //         _descController.text.isEmpty ||
// //         _locationController.text.isEmpty ||
// //         _selectedDate == null) {
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
// //       return;
// //     }
// //
// //     setState(() => _loading = true);
// //
// //     try {
// //       await _firestoreService.createEvent(
// //         title: _titleController.text.trim(),
// //         description: _descController.text.trim(),
// //         location: _locationController.text.trim(),
// //         date: _selectedDate!,
// //         organizerId: widget.organizerId,
// //         organizerName: widget.organizerName,
// //       );
// //
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(const SnackBar(content: Text("Event added successfully")));
// //       Navigator.pop(context);
// //     } catch (e) {
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(SnackBar(content: Text("Error: $e")));
// //     } finally {
// //       setState(() => _loading = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Add Event")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _titleController,
// //               decoration: const InputDecoration(labelText: "Title"),
// //             ),
// //             TextField(
// //               controller: _descController,
// //               decoration: const InputDecoration(labelText: "Description"),
// //             ),
// //             TextField(
// //               controller: _locationController,
// //               decoration: const InputDecoration(labelText: "Location"),
// //             ),
// //             const SizedBox(height: 16),
// //             Row(
// //               children: [
// //                 Text(
// //                   _selectedDate == null
// //                       ? "Pick Date"
// //                       : _selectedDate!.toLocal().toString().split(' ')[0],
// //                 ),
// //                 const SizedBox(width: 10),
// //                 ElevatedButton(
// //                   onPressed: _pickDate,
// //                   child: const Text("Select Date"),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 20),
// //             _loading
// //                 ? const CircularProgressIndicator()
// //                 : SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 onPressed: _submit,
// //                 child: const Text("Add Event"),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import '../../services/firestore_service.dart';
// import 'organizer_home.dart';
// import 'organizer_profile_screen.dart';
//
// class AddEventScreen extends StatefulWidget {
//   final String organizerId;
//   final String organizerName;
//
//   const AddEventScreen({
//     super.key,
//     required this.organizerId,
//     required this.organizerName,
//   });
//
//   @override
//   State<AddEventScreen> createState() => _AddEventScreenState();
// }
//
// class _AddEventScreenState extends State<AddEventScreen> {
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//   final _locationController = TextEditingController();
//   DateTime? _selectedDate;
//   bool _loading = false;
//
//   final FirestoreService _firestoreService = FirestoreService();
//
//   Future<void> _pickDate() async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFF4F46E5),
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color(0xFF111827),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (date != null) setState(() => _selectedDate = date);
//   }
//
//   Future<void> _submit() async {
//     if (_titleController.text.isEmpty ||
//         _descController.text.isEmpty ||
//         _locationController.text.isEmpty ||
//         _selectedDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text("Please fill all fields"),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: const Color(0xFFEF4444),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//       return;
//     }
//
//     setState(() => _loading = true);
//
//     try {
//       await _firestoreService.createEvent(
//         title: _titleController.text.trim(),
//         description: _descController.text.trim(),
//         location: _locationController.text.trim(),
//         date: _selectedDate!,
//         organizerId: widget.organizerId,
//         organizerName: widget.organizerName,
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.white),
//               SizedBox(width: 12),
//               Text("Event created successfully!"),
//             ],
//           ),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: const Color(0xFF10B981),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $e"),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: const Color(0xFFEF4444),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//     } finally {
//       setState(() => _loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text(
//           "Create Event",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF1F2937),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Color(0xFF111827)),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFF4F46E5),
//                     Color(0xFF6366F1),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.event_available,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "New Event",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "Fill in the details below",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Form Section
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE5E7EB)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Event Details",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF111827),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _inputField(
//                     controller: _titleController,
//                     label: "Event Title",
//                     icon: Icons.title,
//                     hint: "Enter event name",
//                   ),
//                   const SizedBox(height: 16),
//                   _inputField(
//                     controller: _descController,
//                     label: "Description",
//                     icon: Icons.description,
//                     hint: "Describe your event",
//                     maxLines: 4,
//                   ),
//                   const SizedBox(height: 16),
//                   _inputField(
//                     controller: _locationController,
//                     label: "Location",
//                     icon: Icons.location_on,
//                     hint: "Where will it take place?",
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Date Picker
//                   const Text(
//                     "Event Date",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xFF374151),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   InkWell(
//                     onTap: _pickDate,
//                     borderRadius: BorderRadius.circular(12),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF9FAFB),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: _selectedDate != null
//                               ? const Color(0xFF4F46E5)
//                               : const Color(0xFFE5E7EB),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: _selectedDate != null
//                                   ? const Color(0xFF4F46E5).withOpacity(0.1)
//                                   : const Color(0xFFE5E7EB),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               Icons.calendar_today,
//                               color: _selectedDate != null
//                                   ? const Color(0xFF4F46E5)
//                                   : const Color(0xFF6B7280),
//                               size: 20,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               _selectedDate == null
//                                   ? "Select event date"
//                                   : _selectedDate!
//                                   .toLocal()
//                                   .toString()
//                                   .split(' ')[0],
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: _selectedDate != null
//                                     ? const Color(0xFF111827)
//                                     : const Color(0xFF9CA3AF),
//                                 fontWeight: _selectedDate != null
//                                     ? FontWeight.w500
//                                     : FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                             color: _selectedDate != null
//                                 ? const Color(0xFF4F46E5)
//                                 : const Color(0xFF9CA3AF),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Submit Button
//             _loading
//                 ? const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF4F46E5),
//               ),
//             )
//                 : SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton(
//                 onPressed: _submit,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4F46E5),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   shadowColor: const Color(0xFF4F46E5).withOpacity(0.3),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add_circle_outline, color: Colors.white),
//                     SizedBox(width: 8),
//                     Text(
//                       "Create Event",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 100), // Space for bottom nav
//           ],
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
//                 _navItem(Icons.home, "Home", false, () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OrganizerHome()),
//                         (route) => false,
//                   );
//                 }),
//                 _navItem(Icons.notifications_outlined, "Notifications", false, () {
//                   // TODO: Navigate to Notifications Screen
//                 }),
//                 _navItem(Icons.person_outline, "Profile", false, () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OrganizerProfileScreen()),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _inputField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     required String hint,
//     int maxLines = 1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF374151),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           maxLines: maxLines,
//           style: const TextStyle(fontSize: 15),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(
//               color: Color(0xFF9CA3AF),
//               fontSize: 14,
//             ),
//             prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
//             filled: true,
//             fillColor: const Color(0xFFF9FAFB),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 14,
//             ),
//           ),
//         ),
//       ],
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

//Latest Version*******************************************
// import 'package:flutter/material.dart';
// import '../../services/firestore_service.dart';
// import 'organizer_home.dart';
// import 'organizer_profile_screen.dart';
//
// class AddEventScreen extends StatefulWidget {
//   final String organizerId;
//   final String organizerName;
//
//   const AddEventScreen({
//     super.key,
//     required this.organizerId,
//     required this.organizerName,
//   });
//
//   @override
//   State<AddEventScreen> createState() => _AddEventScreenState();
// }
//
// class _AddEventScreenState extends State<AddEventScreen> {
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//   final _locationController = TextEditingController();
//   DateTime? _selectedDate;
//   bool _loading = false;
//
//   final FirestoreService _firestoreService = FirestoreService();
//
//   Future<void> _pickDate() async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//       builder: (context, child) => Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(
//             primary: Color(0xFF4F46E5),
//             onPrimary: Colors.white,
//             surface: Colors.white,
//             onSurface: Color(0xFF111827),
//           ),
//         ),
//         child: child!,
//       ),
//     );
//     if (date != null) setState(() => _selectedDate = date);
//   }
//
//   Future<void> _submit() async {
//     if (_titleController.text.isEmpty ||
//         _descController.text.isEmpty ||
//         _locationController.text.isEmpty ||
//         _selectedDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text("Please fill all fields"),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: const Color(0xFFEF4444),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//       return;
//     }
//
//     setState(() => _loading = true);
//
//     try {
//       await _firestoreService.createEvent(
//         title: _titleController.text.trim(),
//         description: _descController.text.trim(),
//         location: _locationController.text.trim(),
//         date: _selectedDate!,
//         organizerId: widget.organizerId,
//         organizerName: widget.organizerName,
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.white),
//               SizedBox(width: 12),
//               Text("Event created successfully!"),
//             ],
//           ),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: const Color(0xFF10B981),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $e"),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: const Color(0xFFEF4444),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//     } finally {
//       setState(() => _loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text(
//           "Create Event",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF1F2937),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Color(0xFF111827)),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFF4F46E5),
//                     Color(0xFF6366F1),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.event_available,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "New Event",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "Fill in the details below",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Form Section
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE5E7EB)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Event Details",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF111827),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _inputField(
//                     controller: _titleController,
//                     label: "Event Title",
//                     icon: Icons.title,
//                     hint: "Enter event name",
//                   ),
//                   const SizedBox(height: 16),
//                   _inputField(
//                     controller: _descController,
//                     label: "Description",
//                     icon: Icons.description,
//                     hint: "Describe your event",
//                     maxLines: 4,
//                   ),
//                   const SizedBox(height: 16),
//                   _inputField(
//                     controller: _locationController,
//                     label: "Location",
//                     icon: Icons.location_on,
//                     hint: "Where will it take place?",
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Date Picker
//                   const Text(
//                     "Event Date",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xFF374151),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   InkWell(
//                     onTap: _pickDate,
//                     borderRadius: BorderRadius.circular(12),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF9FAFB),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: _selectedDate != null
//                               ? const Color(0xFF4F46E5)
//                               : const Color(0xFFE5E7EB),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: _selectedDate != null
//                                   ? const Color(0xFF4F46E5).withOpacity(0.1)
//                                   : const Color(0xFFE5E7EB),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               Icons.calendar_today,
//                               color: _selectedDate != null
//                                   ? const Color(0xFF4F46E5)
//                                   : const Color(0xFF6B7280),
//                               size: 20,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               _selectedDate == null
//                                   ? "Select event date"
//                                   : _selectedDate!.toLocal().toString().split(' ')[0],
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: _selectedDate != null
//                                     ? const Color(0xFF111827)
//                                     : const Color(0xFF9CA3AF),
//                                 fontWeight: _selectedDate != null
//                                     ? FontWeight.w500
//                                     : FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                             color: _selectedDate != null
//                                 ? const Color(0xFF4F46E5)
//                                 : const Color(0xFF9CA3AF),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Submit Button
//             _loading
//                 ? const Center(child: CircularProgressIndicator(color: Color(0xFF4F46E5)))
//                 : SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton(
//                 onPressed: _submit,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4F46E5),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   shadowColor: const Color(0xFF4F46E5).withOpacity(0.3),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add_circle_outline, color: Colors.white),
//                     SizedBox(width: 8),
//                     Text(
//                       "Create Event",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 100), // space for bottom nav
//           ],
//         ),
//       ),
//
//       // ===== Bottom Navigation Bar =====
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _navItem(Icons.home, "Home", false, () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OrganizerHome()),
//                         (route) => false,
//                   );
//                 }),
//                 _navItem(Icons.notifications_outlined, "Notifications", false, () {
//                   // TODO: Navigate to Notifications Screen
//                 }),
//                 _navItem(Icons.person_outline, "Profile", false, () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OrganizerProfileScreen()),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _inputField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     required String hint,
//     int maxLines = 1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF374151),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           maxLines: maxLines,
//           style: const TextStyle(fontSize: 15),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
//             prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
//             filled: true,
//             fillColor: const Color(0xFFF9FAFB),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _navItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF9CA3AF), size: 24),
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
import '../../services/firestore_service.dart';

class AddEventScreen extends StatefulWidget {
  final String organizerId;
  final String organizerName;

  const AddEventScreen({
    super.key,
    required this.organizerId,
    required this.organizerName,
  });

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  bool _loading = false;

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF4F46E5),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF111827),
          ),
        ),
        child: child!,
      ),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _submit() async {
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please fill all fields"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFEF4444),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await _firestoreService.createEvent(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        location: _locationController.text.trim(),
        date: _selectedDate!,
        organizerId: widget.organizerId,
        organizerName: widget.organizerName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text("Event created successfully!"),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF10B981),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFEF4444),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Create Event",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF111827)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding + 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Header Banner ──────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.event_available, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Event",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Fill in the details below",
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Form Card ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Event Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _inputField(
                    controller: _titleController,
                    label: "Event Title",
                    icon: Icons.title,
                    hint: "Enter event name",
                  ),
                  const SizedBox(height: 16),
                  _inputField(
                    controller: _descController,
                    label: "Description",
                    icon: Icons.description,
                    hint: "Describe your event",
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  _inputField(
                    controller: _locationController,
                    label: "Location",
                    icon: Icons.location_on,
                    hint: "Where will it take place?",
                  ),
                  const SizedBox(height: 16),

                  // ── Date Picker ──────────────────────────────
                  const Text(
                    "Event Date",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedDate != null
                              ? const Color(0xFF4F46E5)
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _selectedDate != null
                                  ? const Color(0xFF4F46E5).withOpacity(0.1)
                                  : const Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: _selectedDate != null
                                  ? const Color(0xFF4F46E5)
                                  : const Color(0xFF6B7280),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedDate == null
                                  ? "Select event date"
                                  : _selectedDate!.toLocal().toString().split(' ')[0],
                              style: TextStyle(
                                fontSize: 15,
                                color: _selectedDate != null
                                    ? const Color(0xFF111827)
                                    : const Color(0xFF9CA3AF),
                                fontWeight: _selectedDate != null
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: _selectedDate != null
                                ? const Color(0xFF4F46E5)
                                : const Color(0xFF9CA3AF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Submit Button ──────────────────────────────────
            _loading
                ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
            )
                : SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Create Event",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}