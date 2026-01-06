// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   // ===============================
//   // USER PROFILE
//   // ===============================
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
//   Future<Map<String, dynamic>?> getUserData(String uid) async {
//     final doc = await _db.collection('users').doc(uid).get();
//     if (!doc.exists) return null;
//     return doc.data();
//   }
//
//   // ===============================
//   // CLUBS
//   // ===============================
//
//   /// Create a new club
//   Future<void> createClub({
//     required String name,
//     String description = '',
//     List<String> members = const [],
//   }) async {
//     await _db.collection('clubs').add({
//       'name': name,
//       'description': description,
//       'members': members,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   /// Get all clubs
//   Stream<QuerySnapshot> getAllClubs() {
//     return _db.collection('clubs').orderBy('createdAt', descending: true).snapshots();
//   }
//
//   /// Subscribe a volunteer to a club
//   Future<void> subscribeToClub(String userId, String clubId) async {
//     final docRef = _db.collection('volunteerSubscriptions').doc(userId);
//     await docRef.set({
//       'favoriteClubs': FieldValue.arrayUnion([clubId])
//     }, SetOptions(merge: true));
//   }
//
//   /// Unsubscribe a volunteer from a club
//   Future<void> unsubscribeFromClub(String userId, String clubId) async {
//     final docRef = _db.collection('volunteerSubscriptions').doc(userId);
//     await docRef.update({
//       'favoriteClubs': FieldValue.arrayRemove([clubId])
//     });
//   }
//
//   /// Get volunteer's favorite clubs
//   Stream<DocumentSnapshot> getFavoriteClubs(String userId) {
//     return _db.collection('volunteerSubscriptions').doc(userId).snapshots();
//   }
//
//   // ===============================
//   // EVENTS (for Organizer)
//   // ===============================
//   Future<void> createEvent({
//     required String title,
//     required String description,
//     required String location,
//     required DateTime date,
//     required String organizerId,
//     required String organizerName,
//     String? clubId, // optional: link to a club
//   }) async {
//     await _db.collection('events').add({
//       'title': title,
//       'description': description,
//       'location': location,
//       'date': Timestamp.fromDate(date),
//       'organizerId': organizerId,
//       'organizerName': organizerName,
//       'clubId': clubId,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   Stream<QuerySnapshot> getAllEvents() {
//     return _db.collection('events').orderBy('createdAt', descending: true).snapshots();
//   }
//
//   Stream<QuerySnapshot> getEventsForFavoriteClubs(List<String> clubIds) {
//     if (clubIds.isEmpty) {
//       return _db.collection('events').orderBy('createdAt', descending: true).snapshots();
//     }
//     return _db.collection('events')
//         .where('clubId', whereIn: clubIds)
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
//
//   /// Get events for a specific organizer
//   Stream<QuerySnapshot> getEventsByOrganizer(String organizerId) {
//     return _db
//         .collection('events')
//         .where('organizerId', isEqualTo: organizerId)
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
//
//   // ===============================
//   // EVENT REGISTRATION (Volunteer)
//   // ===============================
//   Future<void> registerForEvent({
//     required String eventId,
//     required String userId,
//     required String name,
//     required String email,
//     String phone = '',
//     String emergencyContact = '',
//     String skills = '',
//   }) async {
//     await _db.collection('registrations').add({
//       'eventId': eventId,
//       'userId': userId,
//       'name': name,
//       'email': email,
//       'status': 'joined',
//       'phone': phone,
//       'emergencyContact': emergencyContact,
//       'skills': skills,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   Stream<QuerySnapshot> getUserRegistrations(String userId) {
//     return _db.collection('registrations')
//         .where('userId', isEqualTo: userId)
//         .snapshots();
//   }
//
//   Stream<QuerySnapshot> getRegistrationsForEvent(String eventId) {
//     return _db.collection('registrations')
//         .where('eventId', isEqualTo: eventId)
//         .snapshots();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===============================
  // USER PROFILE
  // ===============================
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

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return doc.data();
  }

  // ===============================
  // CLUBS
  // ===============================
  Future<void> createClub({
    required String name,
    String description = '',
    List<String> members = const [],
  }) async {
    await _db.collection('clubs').add({
      'name': name,
      'description': description,
      'members': members,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAllClubs() {
    return _db.collection('clubs').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> subscribeToClub(String userId, String clubId) async {
    final docRef = _db.collection('volunteerSubscriptions').doc(userId);
    await docRef.set({
      'favoriteClubs': FieldValue.arrayUnion([clubId])
    }, SetOptions(merge: true));
  }

  Future<void> unsubscribeFromClub(String userId, String clubId) async {
    final docRef = _db.collection('volunteerSubscriptions').doc(userId);
    await docRef.update({
      'favoriteClubs': FieldValue.arrayRemove([clubId])
    });
  }

  Stream<DocumentSnapshot> getFavoriteClubs(String userId) {
    return _db.collection('volunteerSubscriptions').doc(userId).snapshots();
  }

  // ===============================
  // EVENTS (for Organizer)
  // ===============================
  Future<void> createEvent({
    required String title,
    required String description,
    required String location,
    required DateTime date,
    required String organizerId,
    required String organizerName,
    String? clubId, // optional: link to a club
  }) async {
    await _db.collection('events').add({
      'title': title,
      'description': description,
      'location': location,
      'date': Timestamp.fromDate(date),
      'organizerId': organizerId,
      'organizerName': organizerName,
      'clubId': clubId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAllEvents() {
    return _db.collection('events').orderBy('createdAt', descending: true).snapshots();
  }

  Stream<QuerySnapshot> getEventsForFavoriteClubs(List<String> clubIds) {
    if (clubIds.isEmpty) {
      return _db.collection('events').orderBy('createdAt', descending: true).snapshots();
    }
    return _db.collection('events')
        .where('clubId', whereIn: clubIds)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// ✅ Get events for a specific organizer
  Stream<QuerySnapshot> getEventsByOrganizer(String organizerId) {
    // Order by createdAt safely; make sure all events have createdAt
    return _db
        .collection('events')
        .where('organizerId', isEqualTo: organizerId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ===============================
  // EVENT REGISTRATION (Volunteer)
  // ===============================
  Future<void> registerForEvent({
    required String eventId,
    required String userId,
    required String name,
    required String email,
    String phone = '',
    String emergencyContact = '',
    String skills = '',
  }) async {
    await _db.collection('registrations').add({
      'eventId': eventId,
      'userId': userId,
      'name': name,
      'email': email,
      'status': 'joined',
      'phone': phone,
      'emergencyContact': emergencyContact,
      'skills': skills,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get all registrations by a specific user
  Stream<QuerySnapshot> getUserRegistrations(String userId) {
    return _db.collection('registrations')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Get all registrations for a specific event
  Stream<QuerySnapshot> getRegistrationsForEvent(String eventId) {
    return _db.collection('registrations')
        .where('eventId', isEqualTo: eventId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
