// // lib/screens/organization/edit_event_screen.dart
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../services/firestore_service.dart';
//
// class EditEventScreen extends StatefulWidget {
//   final String eventId;
//   final Map<String, dynamic> eventData;
//
//   const EditEventScreen({
//     super.key,
//     required this.eventId,
//     required this.eventData,
//   });
//
//   @override
//   State<EditEventScreen> createState() => _EditEventScreenState();
// }
//
// class _EditEventScreenState extends State<EditEventScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _locationController;
//   DateTime? _selectedDate;
//
//   final FirestoreService _firestoreService = FirestoreService();
//
//   @override
//   void initState() {
//     super.initState();
//     _titleController =
//         TextEditingController(text: widget.eventData['title'] ?? '');
//     _descriptionController =
//         TextEditingController(text: widget.eventData['description'] ?? '');
//     _locationController =
//         TextEditingController(text: widget.eventData['location'] ?? '');
//     _selectedDate = (widget.eventData['date'] as Timestamp?)?.toDate() ??
//         DateTime.now();
//   }
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _locationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _updateEvent() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     await _firestoreService.updateEvent(
//       eventId: widget.eventId,
//       title: _titleController.text.trim(),
//       description: _descriptionController.text.trim(),
//       location: _locationController.text.trim(),
//       date: _selectedDate!,
//     );
//
//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("Event updated successfully")));
//
//     Navigator.pop(context);
//   }
//
//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime.now().subtract(const Duration(days: 365)),
//       lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
//     );
//
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Event")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   labelText: "Event Title",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) =>
//                 val == null || val.isEmpty ? "Enter event title" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _descriptionController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(
//                   labelText: "Event Description",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) =>
//                 val == null || val.isEmpty ? "Enter event description" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _locationController,
//                 decoration: const InputDecoration(
//                   labelText: "Location",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) =>
//                 val == null || val.isEmpty ? "Enter location" : null,
//               ),
//               const SizedBox(height: 16),
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: Text(
//                     "Event Date: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : 'Not set'}"),
//                 trailing: const Icon(Icons.calendar_today),
//                 onTap: _pickDate,
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _updateEvent,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   "Update Event",
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/screens/organization/edit_event_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class EditEventScreen extends StatefulWidget {
  final String eventId;
  final Map<String, dynamic> eventData;

  const EditEventScreen({
    super.key,
    required this.eventId,
    required this.eventData,
  });

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  DateTime? _selectedDate;
  bool _loading = false;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.eventData['title'] ?? '');
    _descriptionController =
        TextEditingController(text: widget.eventData['description'] ?? '');
    _locationController =
        TextEditingController(text: widget.eventData['location'] ?? '');
    _selectedDate = (widget.eventData['date'] as Timestamp?)?.toDate() ??
        DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _updateEvent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await _firestoreService.updateEvent(
        eventId: widget.eventId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        date: _selectedDate!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Event updated successfully"),
          backgroundColor: Color(0xFF10B981),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4F46E5),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF111827),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Edit Event",
          style: TextStyle(
            color: Color(0xFF111827),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF111827)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ===== Form Card =====
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
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

                    // Title
                    _inputField(
                      controller: _titleController,
                      label: "Event Title",
                      icon: Icons.title,
                      hint: "Enter event name",
                    ),
                    const SizedBox(height: 16),

                    // Description
                    _inputField(
                      controller: _descriptionController,
                      label: "Description",
                      icon: Icons.description,
                      hint: "Describe your event",
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),

                    // Location
                    _inputField(
                      controller: _locationController,
                      label: "Location",
                      icon: Icons.location_on,
                      hint: "Where will it take place?",
                    ),
                    const SizedBox(height: 16),

                    // Date Picker
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

                    const SizedBox(height: 30),

                    // Update Button
                    _loading
                        ? const Center(
                      child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
                    )
                        : SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _updateEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F46E5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          shadowColor: const Color(0xFF4F46E5).withOpacity(0.3),
                        ),
                        child: const Text(
                          "Update Event",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
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
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
