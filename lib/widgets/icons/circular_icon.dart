import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';

class AppCircularIcon extends StatelessWidget
{
  const AppCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = AppSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,

  });
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null ? backgroundColor! : AppHelperFunctions.isDarkMode(context) ? AppColors.black.withValues(alpha:0.9) : AppColors.white.withValues(alpha: 0.9),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon,color: color, size: size,)),
    );
  }
}
