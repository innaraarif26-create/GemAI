import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ChatRepo {
  ChatRepo(this._db, this._storage);

  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

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
      'type': 'text',
      'status': 'sent',
      'seenBy': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
    });

    await chatRef.update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadCounts': unreadCounts,
    });
  }

  Future<void> sendImageMessage({
    required String chatId,
    required String senderId,
    required String imageUrl,
    String? text,
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
      'text': text ?? '',
      'imageUrl': imageUrl,
      'type': 'image',
      'status': 'sent',
      'seenBy': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
    });

    await chatRef.update({
      'lastMessage': text?.isNotEmpty == true ? text : '📷 Image',
      'lastMessageAt': FieldValue.serverTimestamp(),
      'unreadCounts': unreadCounts,
    });
  }

  Future<String> uploadChatImage({
    required String chatId,
    required String senderId,
    required File imageFile,
  }) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage.ref().child('chats/$chatId/$senderId/$fileName');

    final task = await ref.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return task.ref.getDownloadURL();
  }

  Future<void> markChatRead({
    required String chatId,
    required String userId,
  }) async {
    final chatRef = _db.collection('chats').doc(chatId);
    final chatSnap = await chatRef.get();

    if (!chatSnap.exists) return;

    final data = chatSnap.data() ?? {};
    final unreadCounts = Map<String, dynamic>.from(
      (data['unreadCounts'] as Map?) ?? {},
    );

    unreadCounts[userId] = 0;

    await chatRef.set({
      'unreadCounts': unreadCounts,
    }, SetOptions(merge: true));
  }

  Future<void> markMessageSeen({
    required String chatId,
    required String messageId,
    required String userId,
  }) async {
    final msgRef = _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId);

    await msgRef.set({
      'status': 'seen',
      'seenBy': FieldValue.arrayUnion([userId]),
    }, SetOptions(merge: true));
  }

  Future<void> markMessageDelivered({
    required String chatId,
    required String messageId,
  }) async {
    final msgRef = _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId);

    await msgRef.set({
      'status': 'delivered',
    }, SetOptions(merge: true));
  }

  Future<void> markMessageNotDelivered({
    required String chatId,
    required String messageId,
  }) async {
    final msgRef = _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId);

    await msgRef.set({
      'status': 'not_delivered',
    }, SetOptions(merge: true));
  }

  Future<void> deleteChat(String chatId) async {
    final chatRef = _db.collection('chats').doc(chatId);
    final messagesSnap = await chatRef.collection('messages').get();

    final batch = _db.batch();

    for (final doc in messagesSnap.docs) {
      batch.delete(doc.reference);
    }

    batch.delete(chatRef);

    await batch.commit();
  }
}