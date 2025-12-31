// import 'package:flutter/material.dart';
// import '../../services/firestore_service.dart';
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
//     );
//     if (date != null) setState(() => _selectedDate = date);
//   }
//
//   Future<void> _submit() async {
//     if (_titleController.text.isEmpty ||
//         _descController.text.isEmpty ||
//         _locationController.text.isEmpty ||
//         _selectedDate == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
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
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Event added successfully")));
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     } finally {
//       setState(() => _loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Event")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
//             TextField(controller: _descController, decoration: const InputDecoration(labelText: "Description")),
//             TextField(controller: _locationController, decoration: const InputDecoration(labelText: "Location")),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Text(_selectedDate == null ? "Pick Date" : _selectedDate!.toLocal().toString().split(' ')[0]),
//                 const SizedBox(width: 10),
//                 ElevatedButton(onPressed: _pickDate, child: const Text("Select Date")),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _loading
//                 ? const CircularProgressIndicator()
//                 : SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(onPressed: _submit, child: const Text("Add Event")),
//             ),
//           ],
//         ),
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
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _submit() async {
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
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

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Event added successfully")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "Pick Date"
                      : _selectedDate!.toLocal().toString().split(' ')[0],
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text("Select Date"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text("Add Event"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
