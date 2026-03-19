import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepo {
  ChatRepo(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _chats =>
      _db.collection('chats');

  CollectionReference<Map<String, dynamic>> _messages(String chatId) =>
      _chats.doc(chatId).collection('messages');

  /// Create chat doc if not exists
  Future<void> createOrGetChat({
    required String chatId,
    required String buyerId,
    required String sellerId,
    required String productId,
  }) async {
    final ref = _chats.doc(chatId);
    final snap = await ref.get();
    if (snap.exists) return;

    await ref.set({
      'chatId': chatId,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'productId': productId,
      'lastMessage': '',
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastSenderId': '',
      'unreadCounts': {
        buyerId: 0,
        sellerId: 0,
      },
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messagesStream(String chatId) {
    return _messages(chatId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Stream user chats (buyer OR seller)
  Stream<QuerySnapshot<Map<String, dynamic>>> userChatsStream(String userId) {

    return _chats
        .where('members', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots();
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final chatRef = _chats.doc(chatId);
    final msgRef = _messages(chatId).doc();

    await _db.runTransaction((tx) async {
      final chatSnap = await tx.get(chatRef);
      if (!chatSnap.exists) {
        throw Exception('Chat does not exist.');
      }

      final data = chatSnap.data() as Map<String, dynamic>;
      final buyerId = (data['buyerId'] ?? '') as String;
      final sellerId = (data['sellerId'] ?? '') as String;

      final receiverId = senderId == buyerId ? sellerId : buyerId;

      tx.set(msgRef, {
        'senderId': senderId,
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // increment unread for receiver, reset not needed for sender
      tx.update(chatRef, {
        'lastMessage': text,
        'lastMessageAt': FieldValue.serverTimestamp(),
        'lastSenderId': senderId,
        'unreadCounts.$receiverId': FieldValue.increment(1),
      });
    });
  }

  Future<void> markChatRead({
    required String chatId,
    required String userId,
  }) async {
    await _chats.doc(chatId).update({
      'unreadCounts.$userId': 0,
    });
  }

  /// Optional helper to ensure schema supports userChatsStream().
  Future<void> ensureMembersField({
    required String chatId,
  }) async {
    final ref = _chats.doc(chatId);
    final snap = await ref.get();
    if (!snap.exists) return;
    final data = snap.data()!;
    if (data['members'] != null) return;

    final buyerId = (data['buyerId'] ?? '') as String;
    final sellerId = (data['sellerId'] ?? '') as String;

    await ref.update({
      'members': [buyerId, sellerId],
    });
  }
}