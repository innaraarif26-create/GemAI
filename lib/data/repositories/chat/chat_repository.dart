import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatRepo {
  ChatRepo(this._db);
  final FirebaseFirestore _db;

  Future<String> createOrGetChat({
    required String chatId,
    required String buyerId,
    required String sellerId,
    required String productId,
  }) async {
    final ref = _db.collection('chats').doc(chatId);

    final payload = <String, dynamic>{
      'participants': [buyerId, sellerId],
      'buyerId': buyerId,
      'sellerId': sellerId,
      'productId': productId,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': '',
      'lastMessageAt': FieldValue.serverTimestamp(),
    };

    debugPrint('CHAT SET payload for chats/$chatId => $payload');

    await ref.set(payload, SetOptions(merge: true));

    return chatId;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messagesStream(String chatId) {
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final chatRef = _db.collection('chats').doc(chatId);
    final msgRef = chatRef.collection('messages').doc();

    await msgRef.set({
      'senderId': senderId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await chatRef.update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }
}