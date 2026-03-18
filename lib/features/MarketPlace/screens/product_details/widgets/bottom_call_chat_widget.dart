import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../data/repositories/call/webrtc_call_repository.dart';
import '../../../../../services/Firebase/webrtc_service.dart';
import '../../../models/product_model.dart';
import '../../call/outgoing_call_screen.dart';

class AppBottomCallAndChat extends StatelessWidget {
  const AppBottomCallAndChat({super.key, required this.product});

  final ProductModel product;

  Future<void> _onCallTap(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please login to call')));
      return;
    }

    final callerId = user.uid;
    final calleeId = product.sellerId;

    if (callerId == calleeId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can't call yourself")),
      );
      return;
    }

    final repo = WebRtcCallRepo(FirebaseFirestore.instance);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OutgoingCallScreen(
          repo: repo,
          webRtc: WebRtcService(),
          callerId: callerId,
          calleeId: calleeId,
          productId: product.id,
          calleeName: product.sellerName,
        ),
      ),
    );
  }

  void _onChatTap(BuildContext context) {
    // Your chat navigation can be added here later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat not implemented here yet')),
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
            onPressed: () => _onCallTap(context),
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
              onPressed: () => _onChatTap(context),
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