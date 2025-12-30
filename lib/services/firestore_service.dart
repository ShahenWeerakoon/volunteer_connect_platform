import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create or update a user profile in Firestore
  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String name,
    required String phone,
    required String role,
  }) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get user profile by UID
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return doc.data();
  }
}
