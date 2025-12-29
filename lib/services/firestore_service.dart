import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create or update a user profile in Firestore
  Future<void> saveUserProfile({
    required String uid,
    required String email,
    String? name,
  }) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'name': name ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get user profile by UID
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(String uid) async {
    return await _db.collection('users').doc(uid).get();
  }
}
