import 'package:flutter/material.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/bottom_call_chat_widget.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/price_share_widget.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_location.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_posted_by_widget.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_safety_widget.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../widgets/texts/product_title_text.dart';


class ProductDetailScreen extends StatelessWidget
{
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: AppBottomCallAndChat(),
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
                  AppProductLocation(location: 'Danyore, Gilgit',),
                  const SizedBox(height: AppSizes.defaultSpace),

                  /// Product Details
                  AppProductMetaData(),
                  const SizedBox(height: AppSizes.defaultSpace),

                  /// Description
                  Text("Description", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600,),),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const ReadMoreText(
                    "Discover the elegance and beauty of a Certified Natural Emerald Necklace, a true masterpiece that combines natural splendor with sophisticated craftsmanship. Each emerald has been carefully selected for its vibrant green hue, clarity, and brilliance, ensuring a necklace that exudes luxury and style.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: " Less",
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: AppSizes.spaceBtwItems),


                  /// Posted By
                    const AppPostedBy(
                    sellerName: "Tufail Haider",
                    sellerImageUrl: AppImages.user,                  ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    const Divider(),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Safety Notice Section
                  AppProductSafetyNotice(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
