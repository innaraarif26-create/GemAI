import 'package:flutter/material.dart';
import 'package:GemAI/%20features/shop/screens/product_details/product_detail.dart';
import 'package:GemAI/core/constants/colors.dart';
import 'package:GemAI/core/constants/image_strings.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:GemAI/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:GemAI/widgets/image_widget/rounded_image.dart';
import 'package:GemAI/widgets/texts/product_title_text.dart';
import 'package:get/get.dart';
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
       onTap: () => Get.to(()=> const ProductDetailScreen()) ,
       child: Container(
          width: 180,
          padding: const EdgeInsets.all(1),
          decoration:  BoxDecoration(
           boxShadow: [AppShadowStyle.verticalProductShadow],
           borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
           color: dark ? AppColors.darkerGrey : AppColors.white,
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             /// Thumbnail,Wishlist button
              AppRoundedContainer(
                height: 170,
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
                        padding: EdgeInsets.only(left: AppSizes.xs),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppProductTitleText(title: "Emerald Necklace ",smallSize: false,),
                            SizedBox(height: AppSizes.spaceBtwItems / 2,),
                            Row(
                              children: [
                                const Icon(Icons.person,size: 14,color: AppColors.grey,),
                                const SizedBox(width: AppSizes.xs,),
                                AppProductTitleText(title: "Shahab",smallSize: true,),
                              ],
                            ),
                            const SizedBox(height: AppSizes.xs,),
                            AppProductTitleText(title: "\$35.5"),
                          ],
                        ),
                    )
                  ],
                ),
              ),
     );
   }
 }


