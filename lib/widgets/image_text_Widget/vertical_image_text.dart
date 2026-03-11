import 'package:flutter/material.dart';
import 'package:gemai/widgets/image_widget/circular_image.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/utils/helpers/helper_functions.dart';

class AppVerticalImageText extends StatelessWidget {
  const AppVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor= AppColors.white,
    this.backgroundColor,
    this.onTap,
    this.borderRadius = 100,
     this.isNetworkImage = true,
  });

  final String image,title;
  final Color textColor;
  final Color? backgroundColor;
  final double borderRadius;
  final bool isNetworkImage;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            AppCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: AppSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: AppHelperFunctions.isDarkMode(context) ? AppColors.light : AppColors.dark,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems/2),
            SizedBox(
              width: 60,
              child: Center(
                child: Text(title,style: Theme.of(context).textTheme.bodySmall!.apply(color: textColor),
                  maxLines: 1,overflow: TextOverflow.ellipsis ,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


