// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:volunteer_connect_platform/screens/auth/register_screen.dart';
// // import 'package:flutter/material.dart';
// // import '../../services/auth_service.dart';
// // import 'register_screen.dart';
// //
// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});
// //
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   bool _loading = false;
// //
// //   void _login() async {
// //     setState(() => _loading = true);
// //
// //     try {
// //       await _auth.signInWithEmailAndPassword(
// //         email: _emailController.text.trim(),
// //         password: _passwordController.text.trim(),
// //       );
// //       // AuthWrapper will navigate automatically
// //     } on FirebaseAuthException catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text(e.message ?? "Login failed")),
// //       );
// //     } finally {
// //       setState(() => _loading = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Login")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
// //             TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
// //             const SizedBox(height: 20),
// //             _loading
// //                 ? const CircularProgressIndicator()
// //                 : ElevatedButton(onPressed: _login, child: const Text("Login")),
// //             TextButton(
// //               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
// //               child: const Text("Create new account"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'register_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool _loading = false;
//
//   Future<void> _login() async {
//     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//       _showMessage("Please enter your credentials");
//       return;
//     }
//
//     setState(() => _loading = true);
//
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       _showMessage(e.message ?? "Login failed");
//     } finally {
//       setState(() => _loading = false);
//     }
//   }
//
//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Color(0xFF6B7280)),
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 420),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 80),
//
//                   // App name / Welcome
//                   const Text(
//                     "Welcome to VolunteerConnect",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF111827),
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     "Sign in to manage your events and volunteers",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // Email
//                   TextField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: _inputDecoration("Email address"),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Password
//                   TextField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: _inputDecoration("Password"),
//                   ),
//
//                   const SizedBox(height: 32),
//
//                   // Continue button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: _loading ? null : _login,
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         backgroundColor: const Color(0xFF4F46E5), // theme primary
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: _loading
//                           ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.white,
//                         ),
//                       )
//                           : const Text(
//                         "Continue",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 28),
//
//                   // Sign up
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don’t have an account?",
//                           style: TextStyle(color: Color(0xFF6B7280)),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => const RegisterScreen(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Create account",
//                             style: TextStyle(
//                               color: Color(0xFF4F46E5),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage("Please enter your credentials");
      return;
    }
    setState(() => _loading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? "Login failed");
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4F46E5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ── Indigo Header ──────────────────────────────────────────
          Container(
            color: const Color(0xFF4F46E5),
            padding: const EdgeInsets.fromLTRB(24, 72, 24, 36),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.people_outline,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Sign in to VolunteerConnect',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),

          // ── Form ──────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  // Email
                  _fieldLabel('Email address'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _emailController,
                    hint: 'you@example.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // Password label + forgot
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _fieldLabel('Password'),
                      TextButton(
                        onPressed: () {/* TODO: forgot password */},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _passwordController,
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF9CA3AF),
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF4F46E5),
                        disabledBackgroundColor:
                        const Color(0xFF4F46E5).withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                          : const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Divider
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(color: Color(0xFFE5E7EB))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[400])),
                      ),
                      const Expanded(
                          child: Divider(color: Color(0xFFE5E7EB))),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Google Sign-In button
                  OutlinedButton(
                    onPressed: () {/* TODO: Google sign-in */},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://www.google.com/favicon.ico',
                          width: 18,
                          height: 18,
                          errorBuilder: (_, __, ___) => const Icon(
                              Icons.g_mobiledata,
                              color: Color(0xFF4285F4),
                              size: 22),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign up link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 13, color: Color(0xFF6B7280)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RegisterScreen()),
                          ),
                          child: const Text(
                            'Create account',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        prefixIcon:
        Icon(prefixIcon, color: const Color(0xFF9CA3AF), size: 18),
        suffixIcon: suffixIcon,
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
          borderSide:
          const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}