import 'package:flutter/cupertino.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';

class AppRoundedContainer extends StatelessWidget
{
  const AppRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = AppSizes.cardRadiusLg,
    this.showBorder = false,
    this.borderColor = AppColors.borderPrimary,
    this.backgroundColor = AppColors.white,
  });

  final double? width;
  final double? height;
  final double  radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}


