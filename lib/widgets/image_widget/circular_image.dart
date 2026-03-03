import 'package:flutter/cupertino.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import '../../core/constants/sizes.dart';

class AppCircularImage extends StatelessWidget
{
  const AppCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = AppSizes.sm,
  });

  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width,height,padding;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (AppHelperFunctions.isDarkMode(context) ? AppColors.black : AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Image(image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
          color: overlayColor,
          fit: fit,
        ),
      ),
    );
  }
}
