import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/utils/helpers/helper_functions.dart';

class AppVerticalImageText extends StatelessWidget {
  const AppVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor= AppColors.white,
    this.backgroundColor = AppColors.white,
    this.onTap,
  });

  final String image,title;
  final Color textColor;
  final Color? backgroundColor;
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
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor ?? (dark ? AppColors.black :AppColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(image: AssetImage(image),fit: BoxFit.cover,),
              ),
            ),
            /// Text
            const SizedBox(height: AppSizes.spaceBtwItems/2),
            SizedBox(
              width: 55,
              child: Text(title,style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}


