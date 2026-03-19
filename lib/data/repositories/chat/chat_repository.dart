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
      'chatId': chatId,
      'participants': [buyerId, sellerId],
      'buyerId': buyerId,
      'sellerId': sellerId,
      'productId': productId,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': '',
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadCounts': {
        buyerId: 0,
        sellerId: 0,
      },
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
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userChatsStream(String userId) {
    return _db
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots();
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final chatRef = _db.collection('chats').doc(chatId);
    final msgRef = chatRef.collection('messages').doc();

    final chatSnap = await chatRef.get();
    if (!chatSnap.exists) {
      throw StateError('Chat $chatId does not exist.');
    }

    final data = chatSnap.data() ?? {};
    final buyerId = data['buyerId'] as String?;
    final sellerId = data['sellerId'] as String?;

    final unreadCounts = Map<String, dynamic>.from(
      (data['unreadCounts'] as Map?) ?? {},
    );

    if (buyerId != null && sellerId != null) {
      final recipientId = senderId == buyerId ? sellerId : buyerId;
      unreadCounts[recipientId] =
          ((unreadCounts[recipientId] as num?)?.toInt() ?? 0) + 1;
    }

    await msgRef.set({
      'senderId': senderId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await chatRef.update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadCounts': unreadCounts,
    });
  }

  Future<void> markChatRead({
    required String chatId,
    required String userId,
  }) async {
    final ref = _db.collection('chats').doc(chatId);

    // Use set with merge instead of update
    await ref.set({
      'unreadCounts': {
        userId: 0,
      }
    }, SetOptions(merge: true));
  }
}