import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:gemai/widgets/image_widget/rounded_image.dart';
import 'package:iconsax/iconsax.dart';
import '../../icons/circular_icon.dart';
import '../../styles/shadows.dart';

class AppProductCardVertical extends StatelessWidget
{
   const AppProductCardVertical({super.key});

   @override
   Widget build(BuildContext context)
   {
     final dark = AppHelperFunctions.isDarkMode(context);

     return GestureDetector(
       onTap: (){},
       child: Container(
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
              AppRoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(AppSizes.sm),
                backgroundColor: dark ? AppColors.dark : AppColors.light,
                child: Stack(
                  children: [
                    /// Thumbnail image
                    AppRoundedImage(imageUrl: AppImages.product3,applyImageRadius: true,),
                    /// Favorite Icon Button
                   const Positioned(
                      top: 0,
                      right: 0,
                      child: AppCircularIcon(icon: Iconsax.heart5,color: Colors.red,)),
                    ],
                ),
              ),
                    const SizedBox(height: AppSizes.spaceBtwItems/2,),
                    /// Details
                    Padding(
                        padding: EdgeInsets.only(left: AppSizes.sm),
                        child: Column(
                          children: [
                            Text("Emerald Necklace",
                              style: Theme.of(context).textTheme.labelLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                            Text("\$35.5",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:  Theme.of(context).textTheme.headlineMedium,

                            )
                          ],
                        ),
                    )
                  ],
                ),
              ),
     );
   }
 }


