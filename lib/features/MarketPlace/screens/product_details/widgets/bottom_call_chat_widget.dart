import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../data/repositories/chat/chat_repository.dart';
import '../../../../../services/Firebase/call_service.dart';
import '../../../models/product_model.dart';
import '../../../chat/chat_id.dart';
import '../../../chat/chat_screen.dart';

class AppBottomCallAndChat extends StatelessWidget {
  const AppBottomCallAndChat({super.key, required this.product});

  final ProductModel product;

  Future<void> onCallTap(BuildContext context) async {
    // You must have seller phone in your product model:
    final phone = product.sellerPhone; // <-- add this to ProductModel
    if (phone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seller phone number not available')),
      );
      return;
    }

    try {
      await CallService.callPhoneNumber(phone);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open dialer: $e')),
      );
    }
  }

  Future<void> onChatTap(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to chat')),
      );
      return;
    }

    final buyerId = currentUser.uid;
    final sellerId = product.sellerId; // <-- add this to ProductModel

    if (sellerId.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seller info not available')),
      );
      return;
    }

    if (sellerId == buyerId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can't chat with yourself")),
      );
      return;
    }

    final chatId = buildChatId(
      buyerId: buyerId,
      sellerId: sellerId,
      productId: product.id,
    );

    final repo = ChatRepo(FirebaseFirestore.instance);
    await repo.createOrGetChat(
      chatId: chatId,
      buyerId: buyerId,
      sellerId: sellerId,
      productId: product.id,
    );

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          chatId: chatId,
          currentUserId: buyerId,
          repo: repo,
          sellerName: product.sellerName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.defaultSpace / 1.5,
      ),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadiusLg),
          topRight: Radius.circular(AppSizes.cardRadiusLg),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () => onCallTap(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.call),
                SizedBox(width: AppSizes.sm),
                Text("Call"),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: ElevatedButton(
              onPressed: () => onChatTap(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.messages),
                  SizedBox(width: AppSizes.sm),
                  Text("Chat"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}