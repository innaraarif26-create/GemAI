import 'package:flutter/material.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/controllers/product_controller.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/bottom_call_chat_widget.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/price_share_widget.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_location.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_meta_data.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_posted_by_widget.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_safety_widget.dart';
import 'package:readmore/readmore.dart';
import '../../../../widgets/texts/product_title_text.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProductController.instance.repo.incrementViews(product.id);
    });

    return Scaffold(
      bottomNavigationBar: const AppBottomCallAndChat(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppProductImageSlider(imageUrls: product.imageUrls),
            Padding(
              padding: const EdgeInsets.only(
                right: AppSizes.defaultSpace,
                left: AppSizes.defaultSpace,
                bottom: AppSizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPriceAndShare(price: product.price),
                  const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
                  AppProductTitleText(title: product.title),
                  const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
                  AppProductLocation(location: product.location),
                  const SizedBox(height: AppSizes.defaultSpace),
                  AppProductMetaData(product: product),
                  const SizedBox(height: AppSizes.defaultSpace),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: " Less",
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  AppPostedBy(
                    sellerName: product.sellerName,
                    sellerImageUrl: product.sellerPhotoUrl.isEmpty ? null : product.sellerPhotoUrl,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const AppProductSafetyNotice(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}