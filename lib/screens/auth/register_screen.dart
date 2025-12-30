// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import '../../common/home_screen.dart';
// import '../common/home_screen.dart';
// import '../../services/firestore_service.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? _role;
//   bool loading = false;
//
//   final FirestoreService _firestoreService = FirestoreService();
//
//   Future<void> register() async {
//     if (_role == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select a role")),
//       );
//       return;
//     }
//
//     setState(() => loading = true);
//
//     try {
//       // Create user in Firebase Auth
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       User? user = userCredential.user;
//
//       if (user != null) {
//         // Save extra info in Firestore using FirestoreService
//         await _firestoreService.saveUserProfile(
//           uid: user.uid,
//           email: emailController.text.trim(),
//           name: nameController.text.trim(),
//           phone: phoneController.text.trim(),
//           role: _role!,
//         );
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Account created successfully")),
//         );
//
//         // Navigate to HomeScreen and clear navigation stack
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//               (route) => false,
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? "Registration failed")),
//       );
//     } finally {
//       setState(() => loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Register")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: "Full Name"),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: "Email"),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(labelText: "Password"),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.phone,
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 value: _role,
//                 items: const [
//                   DropdownMenuItem(value: 'Volunteer', child: Text('Volunteer')),
//                   DropdownMenuItem(value: 'Organizer', child: Text('Organizer')),
//                 ],
//                 hint: const Text('Select your role'),
//                 onChanged: (value) => setState(() => _role = value),
//               ),
//               const SizedBox(height: 20),
//               loading
//                   ? const CircularProgressIndicator()
//                   : SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: register,
//                   child: const Text("Register"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/home_screen.dart'; // Keep this for now, AuthWrapper will handle navigation
import '../../widgets/auth_wrapper.dart'; // Import AuthWrapper
import '../../services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _role;
  bool loading = false;

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> register() async {
    if (_role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a role")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        await _firestoreService.saveUserProfile(
          uid: user.uid,
          email: emailController.text.trim(),
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          role: _role!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")),
        );

        // Navigate to AuthWrapper instead of HomeScreen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'Volunteer', child: Text('Volunteer')),
                  DropdownMenuItem(value: 'Organizer', child: Text('Organizer')),
                ],
                hint: const Text('Select your role'),
                onChanged: (value) => setState(() => _role = value),
              ),
              const SizedBox(height: 20),
              loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: register,
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
