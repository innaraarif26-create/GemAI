import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageController {
  MessageController._private();
  static final MessageController instance = MessageController._private();

  Stream<int> unreadSendersCountStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Stream.value(0);
    }

    final query = FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: uid)
        .where('unreadCounts.$uid', isGreaterThan: 0);

    return query.snapshots().map((snapshot) => snapshot.docs.length);
  }
}