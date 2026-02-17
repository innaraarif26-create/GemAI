import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/sizes.dart';

class AppProductLocation extends StatelessWidget {
  const AppProductLocation({
    super.key,
    required this.location,
    this.icon = Iconsax.location,
    this.iconSize = 14,
  });

  final String location;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Location Icon
        Icon(
          icon,
          size: iconSize,
          color: textStyle?.color,
        ),

        const SizedBox(width: AppSizes.sm),

        /// Location Text
        Expanded(
          child: Text(
            location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}