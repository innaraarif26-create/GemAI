import 'package:flutter/material.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/price_share_widget.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_location.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import '../../../../widgets/texts/product_title_text.dart';


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
            AppProductImageSlider(),

            /// Product Details
            Padding(
              padding: EdgeInsets.only(right: AppSizes.defaultSpace,left: AppSizes.defaultSpace,bottom: AppSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Price And share button
                  AppPriceAndShare(),
                  const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                  ///Title,
                  AppProductTitleText(title: 'Certified Natural Emerald Necklace',),
                  const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                  /// Location
                  AppProductLocation(location: 'Danyore, Gilgit',)
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



