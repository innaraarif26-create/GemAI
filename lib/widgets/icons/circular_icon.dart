import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';

class AppCircularIcon extends StatelessWidget {
  const AppCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = AppSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
    this.elevation = 0,
  });

  final double? width, height;
  final double size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ??
        (AppHelperFunctions.isDarkMode(context)
            ? AppColors.black.withValues(alpha: 0.65)
            : AppColors.white.withValues(alpha: 0.95));

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: const CircleBorder(),
      child: Ink(
        width: width ?? 40,
        height: height ?? 40,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Center(
            child: Icon(icon, color: color, size: size),
          ),
        ),
      ),
    );
  }
}