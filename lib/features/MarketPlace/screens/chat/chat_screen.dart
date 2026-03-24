import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/chat/chat_repository.dart';
import '../../../MarketPlace/models/product_model.dart';
import '../product_details/product_detail.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.currentUserId,
    required this.repo,
    required this.otherName,
    this.otherUserPhotoUrl,
    this.otherUserLastActive,
    this.productTitle,
    this.productPrice,
    this.productImageUrl,
    this.productId,
    this.onDeleteChat,
  });

  final String chatId;
  final String currentUserId;
  final ChatRepo repo;
  final String otherName;

  final String? otherUserPhotoUrl;
  final DateTime? otherUserLastActive;

  final String? productTitle;
  final String? productPrice;
  final String? productImageUrl;
  final String? productId;
  final Future<void> Function()? onDeleteChat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _imagePicker = ImagePicker();

  final List<String> _quickReplies = const [
    'Interested! Still for sale?',
    'Is the price firm?',
    'More details and pictures?',
    'Pickup location?',
    'I want to buy this...',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  String _formatLastActive(DateTime? date) {
    if (date == null) return 'Last active recently';
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return 'Active now';
    if (diff.inMinutes < 60) return 'Active ${diff.inMinutes}m ago';
    if (diff.inHours < 24) return 'Active ${diff.inHours}h ago';
    return 'Active ${diff.inDays}d ago';
  }

  String _groupLabel(DateTime date) {
    final today = DateUtils.dateOnly(DateTime.now());
    final msgDay = DateUtils.dateOnly(date);
    final yesterday = today.subtract(const Duration(days: 1));

    if (msgDay == today) return 'Today';
    if (msgDay == yesterday) return 'Yesterday';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  DateTime _toDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.now();
  }

  Future<void> _send({String? textOverride}) async {
    final text = (textOverride ?? _controller.text).trim();
    if (text.isEmpty) return;

    _controller.clear();
    FocusScope.of(context).unfocus();

    try {
      await widget.repo.sendMessage(
        chatId: widget.chatId,
        senderId: widget.currentUserId,
        text: text,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  Future<void> _pickAndSendImage() async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) return;

      final file = File(picked.path);

      if (!mounted) return;
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) =>
        const Center(child: CircularProgressIndicator()),
      );

      final imageUrl = await widget.repo.uploadChatImage(
        chatId: widget.chatId,
        senderId: widget.currentUserId,
        imageFile: file,
      );

      await widget.repo.sendImageMessage(
        chatId: widget.chatId,
        senderId: widget.currentUserId,
        imageUrl: imageUrl,
      );

      if (!mounted) return;
      Navigator.of(context).pop();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send image: $e')),
        );
      }
    }
  }

  String _messageStatus(Map<String, dynamic> data) {
    return data['status']?.toString().toLowerCase() ?? 'sent';
  }

  Widget _statusIcon(String status) {
    switch (status) {
      case 'seen':
        return const Icon(Icons.done_all, size: 14, color: Colors.blue);
      case 'delivered':
        return const Icon(Icons.done_all, size: 14, color: Colors.white70);
      case 'not_delivered':
      case 'failed':
        return const Icon(Icons.error_outline, size: 14, color: Colors.redAccent);
      case 'sent':
      default:
        return const Icon(Icons.done, size: 14, color: Colors.white70);
    }
  }

  Future<void> _openProduct() async {
    final productId = widget.productId;
    if (productId == null || productId.isEmpty) return;

    try {
      final snap = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();

      if (!snap.exists) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product not found')),
        );
        return;
      }

      final product = ProductModel.fromSnapshot(snap);

      if (!mounted) return;
      Get.to(() => ProductDetailScreen(product: product));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open product: $e')),
      );
    }
  }

  Future<void> _deleteChat() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete chat?'),
        content: const Text('This will remove the chat and all messages.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await widget.onDeleteChat?.call();
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete chat: $e')),
      );
    }
  }

  Widget _buildAvatar({required bool dark}) {
    final url = widget.otherUserPhotoUrl;

    return CircleAvatar(
      radius: 20,
      backgroundColor:
      dark ? Colors.grey.shade800 : AppColors.buttonSecondary,
      backgroundImage: (url != null && url.isNotEmpty) ? NetworkImage(url) : null,
      child: (url == null || url.isEmpty)
          ? Text(
        widget.otherName.isNotEmpty ? widget.otherName[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )
          : null,
    );
  }

  Widget _buildProductHeader({required bool dark}) {
    if (widget.productTitle == null && widget.productImageUrl == null) {
      return const SizedBox.shrink();
    }

    final cardBg = dark ? Colors.grey.shade900 : Colors.white;
    final borderColor = dark ? Colors.white10 : AppColors.darkerGrey.withValues(alpha: 0.35);

    return InkWell(
      onTap: _openProduct,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (dark ? Colors.grey.shade800 : AppColors.grey).withValues(alpha: 0.58),
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 40,
                height: 40,
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: widget.productImageUrl != null &&
                    widget.productImageUrl!.isNotEmpty
                    ? Image.network(
                  widget.productImageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported,
                          color: dark ? Colors.grey.shade300 : null),
                )
                    : Icon(Icons.shopping_bag_outlined,
                    color: dark ? Colors.grey.shade300 : null),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productTitle ?? 'View product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: dark ? Colors.white : null,
                    ),
                  ),
                  if ((widget.productPrice ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.productPrice!,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.buttonSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReplies({required bool dark}) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        scrollDirection: Axis.horizontal,
        itemCount: _quickReplies.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final text = _quickReplies[index];
          return ActionChip(
            label: Text(text),
            onPressed: () => _send(textOverride: text),
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            backgroundColor: AppColors.buttonSecondary.withValues(alpha: 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
              side: BorderSide(color: dark ? Colors.white12 : AppColors.grey),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageBubble(
      String imageUrl, {
        required bool isMe,
        String? timeLabel,
        String? status,
        required bool dark,
      }) {
    final bg = isMe
        ? AppColors.buttonSecondary
        : Theme.of(context).colorScheme.surfaceContainerHighest;

    final fg = isMe
        ? Colors.white
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18).copyWith(
            bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(6),
            bottomRight: isMe ? const Radius.circular(6) : const Radius.circular(18),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 160,
                child: Center(child: Icon(Icons.broken_image_outlined)),
              ),
            ),
            if (timeLabel != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 6, top: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      timeLabel,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: fg.withValues(alpha: 0.75),
                        fontSize: 11,
                      ),
                    ),
                    if (isMe && status != null) ...[
                      const SizedBox(width: 4),
                      _statusIcon(status),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextBubble({
    required String text,
    required bool isMe,
    required String timeLabel,
    String? status,
  }) {
    final bg = isMe
        ? AppColors.buttonSecondary
        : Theme.of(context).colorScheme.surfaceContainerHighest;

    final fg = isMe
        ? Colors.white
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18).copyWith(
            bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(6),
            bottomRight: isMe ? const Radius.circular(6) : const Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fg),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: fg.withValues(alpha: 0.75),
                    fontSize: 11,
                  ),
                ),
                if (isMe && status != null) ...[
                  const SizedBox(width: 4),
                  _statusIcon(status),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem({
    required Map<String, dynamic> data,
    required String currentUserId,
    required bool dark,
  }) {
    final senderId = data['senderId']?.toString() ?? '';
    final isMe = senderId == currentUserId;
    final text = data['text']?.toString() ?? '';
    final type = data['type']?.toString().toLowerCase() ?? 'text';
    final createdAt = _toDateTime(data['createdAt']);
    final timeLabel =
        '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';

    if (type == 'image') {
      final imageUrl = data['imageUrl']?.toString() ?? '';
      return _buildImageBubble(
        imageUrl,
        isMe: isMe,
        timeLabel: timeLabel,
        status: isMe ? _messageStatus(data) : null,
        dark: dark,
      );
    }

    return _buildTextBubble(
      text: text,
      isMe: isMe,
      timeLabel: timeLabel,
      status: isMe ? _messageStatus(data) : null,
    );
  }

  Widget _buildMessages(
      QuerySnapshot<Map<String, dynamic>> snapshot, {
        required bool dark,
      }) {
    final docs = snapshot.docs;
    if (docs.isEmpty) {
      return Center(
        child: Text(
          'No messages yet',
          style: TextStyle(color: dark ? Colors.grey.shade400 : Colors.grey),
        ),
      );
    }

    final List<Widget> items = [];
    String? lastGroup;

    for (final doc in docs) {
      final data = doc.data();
      final createdAt = _toDateTime(data['createdAt']);
      final group = _groupLabel(createdAt);

      if (group != lastGroup) {
        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                group,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: dark ? Colors.grey.shade400 : null,
                ),
              ),
            ),
          ),
        );
        lastGroup = group;
      }

      items.add(
        _buildMessageItem(
          data: data,
          currentUserId: widget.currentUserId,
          dark: dark,
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leadingWidth: 40,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            _buildAvatar(dark: dark),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.otherName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: dark ? Colors.white : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatLastActive(widget.otherUserLastActive),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: dark ? Colors.grey.shade400 : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'More options',
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            offset: const Offset(0, 8),
            onSelected: (value) async {
              if (value == 'delete') {
                await _deleteChat();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'delete',
                height: 48,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Delete chat',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProductHeader(dark: dark),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: widget.repo.messagesStream(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading messages: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: dark ? Colors.white : AppColors.buttonSecondary,
                    ),
                  );
                }
                return _buildMessages(snapshot.data!, dark: dark);
              },
            ),
          ),
          _buildQuickReplies(dark: dark),
          const SizedBox(height: AppSizes.sm),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _pickAndSendImage,
                    icon: const Icon(Iconsax.add, color: AppColors.buttonSecondary),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      minLines: 1,
                      maxLines: 4,
                      style: TextStyle(
                        color: dark ? Colors.white : null,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: dark ? Colors.grey.shade500 : null,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _send,
                    icon: const Icon(Iconsax.send1, color: AppColors.buttonSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}