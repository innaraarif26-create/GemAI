import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../core/constants/sizes.dart';

class AppHomeBooks extends StatelessWidget
{
  const AppHomeBooks({
    super.key,
    required this.image,
    this.onTap,
  });

  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context)
  {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSizes.bookWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppSizes.bookHeight,
              width: AppSizes.bookWidth,
              margin:const EdgeInsets.only(right: AppSizes.spaceBtwItems),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppSizes.xs),

                border: Border.all(color: dark ? Colors.white : Colors.grey.shade400),
                image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}