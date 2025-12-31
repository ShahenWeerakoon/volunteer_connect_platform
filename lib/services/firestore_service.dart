// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // class FirestoreService {
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //
// // //   /// Create or update a user profile in Firestore
// // //   Future<void> saveUserProfile({
// // //     required String uid,
// // //     required String email,
// // //     required String name,
// // //     required String phone,
// // //     required String role,
// // //   }) async {
// // //     await _db.collection('users').doc(uid).set({
// // //       'email': email,
// // //       'name': name,
// // //       'phone': phone,
// // //       'role': role,
// // //       'createdAt': FieldValue.serverTimestamp(),
// // //     });
// // //   }
// // //
// // //   /// Get user profile by UID
// // //   Future<Map<String, dynamic>?> getUserData(String uid) async {
// // //     final doc = await _db.collection('users').doc(uid).get();
// // //     if (!doc.exists) return null;
// // //     return doc.data();
// // //   }
// // // }
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class FirestoreService {
// //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// //
// //   // ===============================
// //   // USER PROFILE
// //   // ===============================
// //
// //   /// Save or update a user profile
// //   Future<void> saveUserProfile({
// //     required String uid,
// //     required String email,
// //     required String name,
// //     required String phone,
// //     required String role,
// //   }) async {
// //     await _db.collection('users').doc(uid).set({
// //       'email': email,
// //       'name': name,
// //       'phone': phone,
// //       'role': role,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   /// Get user profile by UID
// //   Future<Map<String, dynamic>?> getUserData(String uid) async {
// //     final doc = await _db.collection('users').doc(uid).get();
// //     if (!doc.exists) return null;
// //     return doc.data();
// //   }
// //
// //   // ===============================
// //   // EVENTS (for Organizer)
// //   // ===============================
// //
// //   /// Create a new event
// //   Future<void> createEvent({
// //     required String title,
// //     required String description,
// //     required String location,
// //     required DateTime date,
// //     required String organizerId,
// //     required String organizerName,
// //   }) async {
// //     await _db.collection('events').add({
// //       'title': title,
// //       'description': description,
// //       'location': location,
// //       'date': Timestamp.fromDate(date),
// //       'organizerId': organizerId,
// //       'organizerName': organizerName,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   /// Get all events, ordered by creation time
// //   Stream<QuerySnapshot> getAllEvents() {
// //     return _db
// //         .collection('events')
// //         .orderBy('createdAt', descending: true)
// //         .snapshots();
// //   }
// //
// //   // ===============================
// //   // EVENT REGISTRATION (Volunteer)
// //   // ===============================
// //
// //   /// Register a volunteer for an event
// //   Future<void> registerForEvent({
// //     required String eventId,
// //     required String userId,
// //   }) async {
// //     await _db.collection('registrations').add({
// //       'eventId': eventId,
// //       'userId': userId,
// //       'status': 'joined',
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// //
// //   /// Get all registrations of a specific user
// //   Stream<QuerySnapshot> getUserRegistrations(String userId) {
// //     return _db
// //         .collection('registrations')
// //         .where('userId', isEqualTo: userId)
// //         .snapshots();
// //   }
// // }
// //
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   // ===============================
//   // USER PROFILE
//   // ===============================
//
//   /// Save or update a user profile
//   Future<void> saveUserProfile({
//     required String uid,
//     required String email,
//     required String name,
//     required String phone,
//     required String role,
//   }) async {
//     await _db.collection('users').doc(uid).set({
//       'email': email,
//       'name': name,
//       'phone': phone,
//       'role': role,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   /// Get user profile by UID
//   Future<Map<String, dynamic>?> getUserData(String uid) async {
//     final doc = await _db.collection('users').doc(uid).get();
//     if (!doc.exists) return null;
//     return doc.data();
//   }
//
//   // ===============================
//   // EVENTS (for Organizer)
//   // ===============================
//
//   /// Create a new event
//   Future<void> createEvent({
//     required String title,
//     required String description,
//     required String location,
//     required DateTime date,
//     required String organizerId,
//     required String organizerName,
//   }) async {
//     await _db.collection('events').add({
//       'title': title,
//       'description': description,
//       'location': location,
//       'date': Timestamp.fromDate(date),
//       'organizerId': organizerId,
//       'organizerName': organizerName,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   /// Get all events, ordered by creation time
//   Stream<QuerySnapshot> getAllEvents() {
//     return _db
//         .collection('events')
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
//
//   // ===============================
//   // EVENT REGISTRATION (Volunteer)
//   // ===============================
//
//   /// Register a volunteer for an event
//   Future<void> registerForEvent({
//     required String eventId,
//     required String userId,
//   }) async {
//     await _db.collection('registrations').add({
//       'eventId': eventId,
//       'userId': userId,
//       'status': 'joined',
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   /// Get all registrations of a specific user
//   Stream<QuerySnapshot> getUserRegistrations(String userId) {
//     return _db
//         .collection('registrations')
//         .where('userId', isEqualTo: userId)
//         .snapshots();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===============================
  // USER PROFILE
  // ===============================

  /// Save or update a user profile
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

  // ===============================
  // EVENTS (for Organizer)
  // ===============================

  /// Create a new event
  Future<void> createEvent({
    required String title,
    required String description,
    required String location,
    required DateTime date,
    required String organizerId,
    required String organizerName,
  }) async {
    await _db.collection('events').add({
      'title': title,
      'description': description,
      'location': location,
      'date': Timestamp.fromDate(date),
      'organizerId': organizerId,
      'organizerName': organizerName,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get all events, ordered by creation time
  Stream<QuerySnapshot> getAllEvents() {
    return _db
        .collection('events')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ===============================
  // EVENT REGISTRATION (Volunteer)
  // ===============================

  /// Register a volunteer for an event with extra details
  Future<void> registerForEvent({
    required String eventId,
    required String userId,
    String phone = '',
    String emergencyContact = '',
    String skills = '',
  }) async {
    await _db.collection('registrations').add({
      'eventId': eventId,
      'userId': userId,
      'status': 'joined',
      'phone': phone,
      'emergencyContact': emergencyContact,
      'skills': skills,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get all registrations of a specific user
  Stream<QuerySnapshot> getUserRegistrations(String userId) {
    return _db
        .collection('registrations')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
