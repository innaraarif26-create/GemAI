 import 'package:flutter/cupertino.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import '../../styles/shadows.dart';

class AppProductCardVertical extends StatelessWidget
{
   const AppProductCardVertical({super.key});

   @override
   Widget build(BuildContext context)
   {
     final dark = AppHelperFunctions.isDarkMode(context);

     return Container(
        width: 180,
       padding: const EdgeInsets.all(1),
       decoration:  BoxDecoration(
         boxShadow: [AppShadowStyle.verticalProductShadow],
         borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
         color: dark ? AppColors.darkerGrey : AppColors.white,
       ),
       child: Column(
         children: [
           /// Thumbnail,Wishlist button

         ],
       ),
     );
   }
 }
