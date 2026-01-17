// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Register user
//   Future<User?> register(String email, String password) async {
//     try {
//       UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Register error: $e");
//       return null;
//     }
//   }
//
//   // Login user
//   Future<User?> login(String email, String password) async {
//     try {
//       UserCredential userCredential =
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Login error: $e");
//       return null;
//     }
//   }
//
//   // Logout
//   Future<void> logout() async {
//     await _auth.signOut();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Register user
  Future<User?> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role, // "Volunteer" or "Organizer"
  }) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // Build user data
      Map<String, dynamic> userData = {
        'uid': uid,
        'email': email,
        'name': name,
        'phone': phone,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // If organizer, add extra fields
      if (role == 'Organizer') {
        userData.addAll({
          'organizerType': 'individual', // default
          'organizationName': '',
          'bio': '',
          'profileImage': '',
        });
      }

      // Save to Firestore
      await _db.collection('users').doc(uid).set(userData);

      return userCredential.user;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  // Login user
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
