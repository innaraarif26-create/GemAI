import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../core/utils/helpers/helper_functions.dart';

class AppHomeRealFakeList extends StatelessWidget {
  const AppHomeRealFakeList({
    super.key,
    required this.image,
    this.onTap,
    required this.title,
    this.textColor = AppColors.black,
    this.backgroundColor,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? (dark ? AppColors.dark : AppColors.primaryBackground),
          borderRadius: BorderRadius.circular(AppSizes.sm),
            border: Border.all(color: dark ? Colors.white : Colors.grey.shade300)

        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 90,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(height: 4),
            Text("Real vs Fake", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: dark ? Colors.grey[400] : Colors.grey[700],),),
            Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: dark ? Colors.white : Colors.black,),),
          ],
        ),
      ),
    );
  }
}