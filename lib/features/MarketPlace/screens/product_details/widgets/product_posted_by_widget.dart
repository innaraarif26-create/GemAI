import 'package:flutter/material.dart';
import '../../../../../core/constants/sizes.dart';

class AppPostedBy extends StatelessWidget {
  const AppPostedBy({
    super.key,
    required this.sellerName,
    this.sellerImageUrl,
    required this.onTap,
  });

  final String sellerName;
  final String? sellerImageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Avatar + Texts
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: sellerImageUrl != null
                  ? NetworkImage(sellerImageUrl!)
                  : null,
              backgroundColor: Colors.grey.shade400,
              child: sellerImageUrl == null
                  ? const Icon(Icons.person, color: Colors.white, size: 20)
                  : null,
            ),
            const SizedBox(width: AppSizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Posted by",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSizes.xs),
                Text(
                  sellerName,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ],
    );
  }
}