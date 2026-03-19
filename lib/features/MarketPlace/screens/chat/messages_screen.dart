import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/chat/chat_repository.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    super.key,
    required this.currentUserId,
    required this.repo,
  });

  final String currentUserId;
  final ChatRepo repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: repo.userChatsStream(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!.docs;
          if (chats.isEmpty) {
            return const Center(child: Text('No conversations yet'));
          }

          return ListView.separated(
            itemCount: chats.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final data = chats[index].data();
              final chatId = (data['chatId'] ?? chats[index].id) as String;

              final buyerId = (data['buyerId'] ?? '') as String;
              final sellerId = (data['sellerId'] ?? '') as String;
              final otherUserId = currentUserId == buyerId ? sellerId : buyerId;

              final lastMessage = (data['lastMessage'] ?? '') as String;

              final unreadCounts =
                  (data['unreadCounts'] as Map<String, dynamic>?) ?? {};
              final unread =
                  (unreadCounts[currentUserId] as num?)?.toInt() ?? 0;

              return ListTile(
                title: Text('Chat with $otherUserId'),
                subtitle: Text(
                  lastMessage.isEmpty ? 'No messages yet' : lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: unread > 0
                    ? _UnreadBadge(count: unread)
                    : const SizedBox.shrink(),
                onTap: () async {
                  await repo.markChatRead(chatId: chatId, userId: currentUserId);

                  if (!context.mounted) return;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        chatId: chatId,
                        currentUserId: currentUserId,
                        repo: repo,
                        otherName: otherUserId, // replace with real name if you have it
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final text = count > 99 ? '99+' : '$count';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}