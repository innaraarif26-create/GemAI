import 'package:flutter/material.dart';
import '../../core/constants/sizes.dart';

class AppCircularIcon extends StatelessWidget {
  const AppCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = AppSizes.lg,
    required this.icon,
    this.color,
    this.onPressed,
  });

  final double? width, height;
  final double size;
  final IconData icon;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 40,
      height: height ?? 40,
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: (width ?? 40) / 2,
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}