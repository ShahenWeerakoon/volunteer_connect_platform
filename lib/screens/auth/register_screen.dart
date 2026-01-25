// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // // import '../../common/home_screen.dart';
// // import '../common/home_screen.dart';
// // import '../../services/firestore_service.dart';
// //
// // class RegisterScreen extends StatefulWidget {
// //   const RegisterScreen({super.key});
// //
// //   @override
// //   State<RegisterScreen> createState() => _RegisterScreenState();
// // }
// //
// // class _RegisterScreenState extends State<RegisterScreen> {
// //   final nameController = TextEditingController();
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final phoneController = TextEditingController();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   String? _role;
// //   bool loading = false;
// //
// //   final FirestoreService _firestoreService = FirestoreService();
// //
// //   Future<void> register() async {
// //     if (_role == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please select a role")),
// //       );
// //       return;
// //     }
// //
// //     setState(() => loading = true);
// //
// //     try {
// //       // Create user in Firebase Auth
// //       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
// //         email: emailController.text.trim(),
// //         password: passwordController.text.trim(),
// //       );
// //       User? user = userCredential.user;
// //
// //       if (user != null) {
// //         // Save extra info in Firestore using FirestoreService
// //         await _firestoreService.saveUserProfile(
// //           uid: user.uid,
// //           email: emailController.text.trim(),
// //           name: nameController.text.trim(),
// //           phone: phoneController.text.trim(),
// //           role: _role!,
// //         );
// //
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Account created successfully")),
// //         );
// //
// //         // Navigate to HomeScreen and clear navigation stack
// //         Navigator.pushAndRemoveUntil(
// //           context,
// //           MaterialPageRoute(builder: (context) => HomeScreen()),
// //               (route) => false,
// //         );
// //       }
// //     } on FirebaseAuthException catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text(e.message ?? "Registration failed")),
// //       );
// //     } finally {
// //       setState(() => loading = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Register")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: nameController,
// //                 decoration: const InputDecoration(labelText: "Full Name"),
// //               ),
// //               const SizedBox(height: 12),
// //               TextField(
// //                 controller: emailController,
// //                 decoration: const InputDecoration(labelText: "Email"),
// //                 keyboardType: TextInputType.emailAddress,
// //               ),
// //               const SizedBox(height: 12),
// //               TextField(
// //                 controller: passwordController,
// //                 decoration: const InputDecoration(labelText: "Password"),
// //                 obscureText: true,
// //               ),
// //               const SizedBox(height: 12),
// //               TextField(
// //                 controller: phoneController,
// //                 decoration: const InputDecoration(labelText: "Phone Number"),
// //                 keyboardType: TextInputType.phone,
// //               ),
// //               const SizedBox(height: 16),
// //               DropdownButtonFormField<String>(
// //                 value: _role,
// //                 items: const [
// //                   DropdownMenuItem(value: 'Volunteer', child: Text('Volunteer')),
// //                   DropdownMenuItem(value: 'Organizer', child: Text('Organizer')),
// //                 ],
// //                 hint: const Text('Select your role'),
// //                 onChanged: (value) => setState(() => _role = value),
// //               ),
// //               const SizedBox(height: 20),
// //               loading
// //                   ? const CircularProgressIndicator()
// //                   : SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: register,
// //                   child: const Text("Register"),
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
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../common/home_screen.dart'; // Keep this for now, AuthWrapper will handle navigation
// import '../../widgets/auth_wrapper.dart'; // Import AuthWrapper
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
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       User? user = userCredential.user;
//
//       if (user != null) {
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
//         // Navigate to AuthWrapper instead of HomeScreen
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const AuthWrapper()),
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
import 'login_screen.dart';
import '../../widgets/auth_wrapper.dart';
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
  bool _loading = false;

  final FirestoreService _firestoreService = FirestoreService();

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      filled: true,
      fillColor: Colors.white,
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
        borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.2),
      ),
    );
  }

  Future<void> _register() async {
    if (_role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a role")),
      );
      return;
    }

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => _loading = true);

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

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthWrapper()),
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),

                  // App name / Welcome
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Sign up to join and manage events",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Full Name
                  TextField(
                    controller: nameController,
                    decoration: _inputDecoration("Full Name"),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  TextField(
                    controller: emailController,
                    decoration: _inputDecoration("Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    controller: passwordController,
                    decoration: _inputDecoration("Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  // Phone Number
                  TextField(
                    controller: phoneController,
                    decoration: _inputDecoration("Phone Number"),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  // Role Dropdown
                  DropdownButtonFormField<String>(
                    value: _role,
                    items: const [
                      DropdownMenuItem(value: 'Volunteer', child: Text('Volunteer')),
                      DropdownMenuItem(value: 'Organizer', child: Text('Organizer')),
                    ],
                    hint: const Text('Select your role'),
                    onChanged: (value) => setState(() => _role = value),
                    decoration: _inputDecoration("Role"),
                  ),

                  const SizedBox(height: 32),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF4F46E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Already have account? Login
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Color(0xFF6B7280)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
