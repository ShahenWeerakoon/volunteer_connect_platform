// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class OrganizerProfileScreen extends StatefulWidget {
//   const OrganizerProfileScreen({super.key});
//
//   @override
//   State<OrganizerProfileScreen> createState() => _OrganizerProfileScreenState();
// }
//
// class _OrganizerProfileScreenState extends State<OrganizerProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   String name = '';
//   String email = '';
//   String phone = '';
//   String bio = '';
//   String organizerType = 'Individual';
//   String organizationName = '';
//   String profileImageUrl = '';
//
//   File? _imageFile;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }
//
//   Future<void> _loadProfile() async {
//     final uid = _auth.currentUser!.uid;
//     final doc = await _firestore.collection('users').doc(uid).get();
//     if (doc.exists) {
//       final data = doc.data()!;
//       setState(() {
//         name = data['name'] ?? '';
//         email = data['email'] ?? '';
//         phone = data['phone'] ?? '';
//         bio = data['bio'] ?? '';
//         organizerType = data['organizerType'] ?? 'Individual';
//         organizationName = data['organizationName'] ?? '';
//         profileImageUrl = data['profileImage'] ?? '';
//       });
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         _imageFile = File(picked.path);
//       });
//     }
//   }
//
//   Future<String?> _uploadImage(File file) async {
//     final uid = _auth.currentUser!.uid;
//     final ref = FirebaseStorage.instance.ref().child('profile_pics/$uid.jpg');
//     await ref.putFile(file);
//     return await ref.getDownloadURL();
//   }
//
//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     _formKey.currentState!.save();
//
//     final uid = _auth.currentUser!.uid;
//     String? uploadedImageUrl = profileImageUrl;
//
//     if (_imageFile != null) {
//       uploadedImageUrl = await _uploadImage(_imageFile!);
//     }
//
//     await _firestore.collection('users').doc(uid).update({
//       'name': name,
//       'phone': phone,
//       'bio': bio,
//       'organizerType': organizerType,
//       'organizationName': organizationName,
//       'profileImage': uploadedImageUrl,
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Profile updated successfully!")),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Organizer Profile")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _imageFile != null
//                       ? FileImage(_imageFile!)
//                       : profileImageUrl.isNotEmpty
//                       ? NetworkImage(profileImageUrl) as ImageProvider
//                       : const AssetImage('assets/avatar_placeholder.png'),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundColor: Colors.white,
//                       child: const Icon(Icons.edit, size: 18),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 initialValue: name,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 onSaved: (val) => name = val ?? '',
//                 validator: (val) => val!.isEmpty ? 'Enter name' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 initialValue: email,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 enabled: false,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 initialValue: phone,
//                 decoration: const InputDecoration(labelText: 'Phone'),
//                 onSaved: (val) => phone = val ?? '',
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 initialValue: bio,
//                 decoration: const InputDecoration(labelText: 'Bio'),
//                 maxLines: 2,
//                 onSaved: (val) => bio = val ?? '',
//               ),
//               const SizedBox(height: 12),
//               DropdownButtonFormField<String>(
//                 value: organizerType,
//                 items: const [
//                   DropdownMenuItem(value: 'Individual', child: Text('Individual')),
//                   DropdownMenuItem(value: 'Group', child: Text('Group')),
//                 ],
//                 onChanged: (val) => setState(() => organizerType = val!),
//                 decoration: const InputDecoration(labelText: 'Organizer Type'),
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 initialValue: organizationName,
//                 decoration: const InputDecoration(labelText: 'Organization Name'),
//                 onSaved: (val) => organizationName = val ?? '',
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: const Text('Save Changes'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OrganizerProfileScreen extends StatefulWidget {
  const OrganizerProfileScreen({super.key});

  @override
  State<OrganizerProfileScreen> createState() => _OrganizerProfileScreenState();
}

class _OrganizerProfileScreenState extends State<OrganizerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Profile data
  String name = '';
  String phone = '';
  String bio = '';
  String organizerType = 'Individual';
  String organizationName = '';
  String profileImageUrl = '';

  File? _imageFile;
  bool _loading = false;
  bool _editMode = false; // 🔑 toggles between view and edit

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);
    final uid = _auth.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        name = data['name'] ?? '';
        phone = data['phone'] ?? '';
        bio = data['bio'] ?? '';
        organizerType = data['organizerType'] ?? 'Individual';
        organizationName = data['organizationName'] ?? '';
        profileImageUrl = data['profileImage'] ?? '';
      });
    }
    setState(() => _loading = false);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<String?> _uploadImage(File file) async {
    final uid = _auth.currentUser!.uid;
    final ref = FirebaseStorage.instance.ref().child('profile_pics/$uid.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => _loading = true);

    final uid = _auth.currentUser!.uid;
    String? uploadedImageUrl = profileImageUrl;

    if (_imageFile != null) {
      uploadedImageUrl = await _uploadImage(_imageFile!);
    }

    Map<String, dynamic> updatedData = {
      'name': name,
      'phone': phone,
      'bio': bio,
      'organizerType': organizerType,
      'organizationName': organizationName,
      if (_imageFile != null) 'profileImage': uploadedImageUrl,
    };

    await _firestore.collection('users').doc(uid).set(
      updatedData,
      SetOptions(merge: true),
    );

    setState(() {
      _loading = false;
      _editMode = false; // exit edit mode
      profileImageUrl = uploadedImageUrl!;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🎉 Profile updated successfully!"),
        backgroundColor: Colors.indigo,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizer Profile"),
        actions: [
          if (!_loading)
            IconButton(
              icon: Icon(_editMode ? Icons.close : Icons.edit),
              onPressed: () {
                setState(() {
                  _editMode = !_editMode;
                  _imageFile = null; // discard picked image if cancelling
                  if (!_editMode) _loadProfile(); // reload original data if cancel
                });
              },
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : const AssetImage(
                        'assets/avatar_placeholder.png') as ImageProvider,
                  ),
                  if (_editMode)
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.camera_alt, size: 20),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: 'Name',
                initialValue: name,
                enabled: _editMode,
                onSaved: (val) => name = val ?? name,
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                label: 'Phone',
                initialValue: phone,
                enabled: _editMode,
                onSaved: (val) => phone = val ?? phone,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                label: 'Bio',
                initialValue: bio,
                enabled: _editMode,
                maxLines: 2,
                onSaved: (val) => bio = val ?? bio,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: organizerType,
                items: const [
                  DropdownMenuItem(
                      value: 'Individual', child: Text('Individual')),
                  DropdownMenuItem(value: 'Group', child: Text('Group')),
                ],
                onChanged: _editMode
                    ? (val) => setState(() => organizerType = val!)
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Organizer Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              _buildTextField(
                label: 'Organization Name',
                initialValue: organizationName,
                enabled: _editMode,
                onSaved: (val) => organizationName = val ?? organizationName,
              ),
              const SizedBox(height: 25),
              if (_editMode)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        child: const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required bool enabled,
    int maxLines = 1,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
