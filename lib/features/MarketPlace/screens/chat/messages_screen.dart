import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../data/repositories/chat/chat_repository.dart';
import '../../../MarketPlace/models/product_model.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    super.key,
    required this.currentUserId,
    required this.repo,
  });

  final String currentUserId;
  final ChatRepo repo;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }//

  Future<Map<String, dynamic>?> _getUserData(String userId) async {
    try {
      final doc = await _db.collection('Users').doc(userId).get();
      return doc.data();
    } catch (e) {
      debugPrint('Error fetching user $userId: $e');
      return null;
    }
  }

  Future<ProductModel?> _getProduct(String productId) async {
    try {
      final doc = await _db.collection('Products').doc(productId).get();
      if (!doc.exists) return null;
      return ProductModel.fromSnapshot(doc);
    } catch (e) {
      debugPrint('Error fetching product $productId: $e');
      return null;
    }
  }

  String _formatTime(Timestamp? timestamp) {
    if (timestamp == null) return '';
    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) return 'now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m';
    if (difference.inHours < 24) return '${difference.inHours}h';
    if (difference.inDays == 1) return 'yesterday';
    if (difference.inDays < 7) return '${difference.inDays}d';
    return DateFormat('MMM d').format(dateTime);
  }

  String _getUserName(Map<String, dynamic>? userData) {
    if (userData == null) return 'User';
    final first = (userData['FirstName'] as String?) ?? '';
    final last = (userData['LastName'] as String?) ?? '';
    final full = ('$first $last').trim();
    if (full.isNotEmpty) return full;
    return (userData['Username'] as String?) ?? 'User';
  }

  String _getUserImage(Map<String, dynamic>? userData) {
    if (userData == null) return '';
    return (userData['ProfilePicture'] as String?) ?? '';
  }

  bool _matchesSearch(String userName, String productName, String lastMessage) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return true;

    return userName.toLowerCase().contains(q) ||
        productName.toLowerCase().contains(q) ||
        lastMessage.toLowerCase().contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: dark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
          iconSize: 20,
        ),
        backgroundColor: dark ? Colors.black : Colors.white,
        foregroundColor: dark ? Colors.white : Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  prefixIcon: Icon(
                    Iconsax.search_favorite,
                    color: dark ? AppColors.darkerGrey : Colors.grey,
                    size: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                      : null,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: widget.repo.userChatsStream(widget.currentUserId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final chats = snapshot.data?.docs ?? [];
                if (chats.isEmpty) {
                  return const Center(child: Text('No conversations yet'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: chats.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = chats[index];
                    final data = doc.data();

                    final chatId = (data['chatId'] as String?) ?? doc.id;
                    final buyerId = (data['buyerId'] as String?) ?? '';
                    final sellerId = (data['sellerId'] as String?) ?? '';
                    final productId = (data['productId'] as String?) ?? '';
                    final otherUserId =
                    widget.currentUserId == buyerId ? sellerId : buyerId;

                    final lastMessage = (data['lastMessage'] as String?) ?? '';
                    final lastMessageAt = data['lastMessageAt'] as Timestamp?;

                    final unreadCounts =
                    Map<String, dynamic>.from((data['unreadCounts'] as Map?) ?? {});
                    final unread =
                        (unreadCounts[widget.currentUserId] as num?)?.toInt() ?? 0;

                    return FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        _getUserData(otherUserId),
                        _getProduct(productId),
                      ]),
                      builder: (context, snap) {
                        if (!snap.hasData) {
                          return const SizedBox.shrink();
                        }

                        final userData = snap.data![0] as Map<String, dynamic>?;
                        final product = snap.data![1] as ProductModel?;

                        final userName = _getUserName(userData);
                        final userImage = _getUserImage(userData);
                        final productName = product?.title ?? 'Product';
                        final productImage =
                        (product != null && product.imageUrls.isNotEmpty) ? product.imageUrls.first : null;

                        if (!_matchesSearch(userName, productName, lastMessage)) {
                          return const SizedBox.shrink();
                        }

                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          elevation: 3,
                          shadowColor: Colors.black12,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () async {
                              await widget.repo.markChatRead(
                                chatId: chatId,
                                userId: widget.currentUserId,
                              );

                              if (!context.mounted) return;

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                    chatId: chatId,
                                    currentUserId: widget.currentUserId,
                                    repo: widget.repo,
                                    otherName: userName,
                                    otherUserPhotoUrl: userImage.isNotEmpty ? userImage : null,
                                    productTitle: product?.title,
                                    productPrice: product?.price.toString(),
                                    productImageUrl: productImage,
                                    productId: productId,
                                    onDeleteChat: () async {
                                      await widget.repo.deleteChat(chatId);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: productImage != null
                                            ? Image.network(
                                          productImage,
                                          width: 55,
                                          height: 58,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Container(
                                                width: 55,
                                                height: 58,
                                                color: Colors.grey.shade200,
                                                child: const Icon(Icons.image_not_supported),
                                              ),
                                        )
                                            : Container(
                                          width: 55,
                                          height: 58,
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.image),
                                        ),
                                      ),
                                      Positioned(
                                        right: -8,
                                        bottom: -8,
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade500,
                                                Colors.green.shade400,
                                              ],
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: userImage.isNotEmpty
                                                ? Image.network(
                                              userImage,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  _initialAvatar(userName),
                                            )
                                                : _initialAvatar(userName),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppSectionHeading(title: userName),
                                            ),
                                            Text(
                                              _formatTime(lastMessageAt),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          productName,
                                          style: Theme.of(context).textTheme.bodySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          lastMessage.isEmpty ? 'No messages yet' : lastMessage,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (unread > 0) _UnreadBadge(count: unread),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _initialAvatar(String name) {
    final initials = name
        .trim()
        .split(' ')
        .where((e) => e.isNotEmpty)
        .take(2)
        .map((e) => e[0].toUpperCase())
        .join();

    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Text(
          initials.isEmpty ? 'U' : initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}