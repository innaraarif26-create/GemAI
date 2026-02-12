import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/helpers/helper_functions.dart';

class AppHomeArticles extends StatelessWidget {
  const AppHomeArticles({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AppColors.black,
    this.backgroundColor = AppColors.primaryBackground,
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
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: backgroundColor ?? (dark ? AppColors.black :AppColors.white),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [ BoxShadow(color: Colors.grey.withValues(alpha: 0.2))]
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top:Radius.circular(6) ),
              child: Image(image: AssetImage(image),fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child:  Text(title,style: Theme.of(context).textTheme.bodyMedium,),
            )
          ],
        ),
      ),
    );
  }
}
