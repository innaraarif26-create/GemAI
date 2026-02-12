import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/image_strings.dart';

class AppHomeArticles extends StatelessWidget {
  const AppHomeArticles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [ BoxShadow(color: Colors.grey.withValues(alpha: 0.2))]
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top:Radius.circular(6) ),
              child: Image.asset(AppImages.article3,fit: BoxFit.fill,),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child:  Text("How to tell if a diamond is real",style: Theme.of(context).textTheme.bodyMedium,),
            )
          ],
        ),
      ),
    );
  }
}
