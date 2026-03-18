import 'package:cloud_firestore/cloud_firestore.dart';

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
    final snap = await ref.get();

    if (!snap.exists) {
      await ref.set({
        'participants': [buyerId, sellerId],
        'buyerId': buyerId,
        'sellerId': sellerId,
        'productId': productId,
        'lastMessage': '',
        'lastMessageAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

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