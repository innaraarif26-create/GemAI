import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:gemai/widgets/icons/circular_icon.dart';
import 'package:gemai/widgets/image_widget/rounded_image.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';

class ProductDetailScreen extends StatelessWidget
{
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            AppCurvedEdgeWidget(
              child: Container(
                color:  dark ? AppColors.darkerGrey : AppColors.light,
                child: Stack(
                  children: [
                    /// Main Large Image
                    SizedBox(height:400, child: Padding(
                      padding: const EdgeInsets.all(AppSizes.productImageRadius * 2),
                      child: Center(child: Image(image: AssetImage(AppImages.product3))),
                    )),
                    /// Image Slider
                    Positioned(
                      right: 0,
                      bottom: 30,
                      left: AppSizes.defaultSpace,
                      child: SizedBox(
                        height: 80,
                        child: ListView.separated(
                          shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (_, __) => const SizedBox(width: AppSizes.spaceBtwItems),
                            itemCount: 4,
                            itemBuilder: (_, index) => AppRoundedImage(
                            width: 80,
                            backgroundColor: dark ? AppColors.dark : AppColors.white,
                            border: Border.all(color: AppColors.accent),
                            padding: const EdgeInsets.all(AppSizes.sm),
                            imageUrl: AppImages.product2
                        ),),
                      ),
                    ),
                    /// Appbar Icons
                    AppAppBar(
                      showBackArrow: true,
                      actions: [
                        AppCircularIcon(icon: Iconsax.heart5,color: Colors.red,)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
