import 'package:flutter/material.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class AppBottomCallAndChat extends StatelessWidget {
  const AppBottomCallAndChat({super.key});

  void onCallTap() {}

  void onChatTap() {}

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace, vertical: AppSizes.defaultSpace / 2,),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSizes.cardRadiusLg), topRight: Radius.circular(AppSizes.cardRadiusLg),),
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
          /// Call Button
          OutlinedButton(
            onPressed: onCallTap,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 38,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Iconsax.call),
                SizedBox(width: AppSizes.sm),
                Text("Call"),
              ],
            ),
          ),

          const SizedBox(width: AppSizes.sm),

          /// Chat Button
          Expanded(
            child: ElevatedButton(
              onPressed: onChatTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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