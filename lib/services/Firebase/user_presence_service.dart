import 'package:cloud_firestore/cloud_firestore.dart';

class UserPresenceService {
  UserPresenceService._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> setOnline(String userId) async {
    await _db.collection('Users').doc(userId).set({
      'isOnline': true,
      'LastActive': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> setOffline(String userId) async {
    await _db.collection('Users').doc(userId).set({
      'isOnline': false,
      'LastActive': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> updateLastActive(String userId) async {
    await _db.collection('Users').doc(userId).set({
      'LastActive': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}