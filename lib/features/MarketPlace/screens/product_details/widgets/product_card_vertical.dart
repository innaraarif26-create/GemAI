import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/features/MarketPlace/controllers/wishlist_controller.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:gemai/widgets/image_widget/rounded_image.dart';
import 'package:gemai/widgets/texts/product_title_text.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../product_details/product_detail.dart';
import '../../../../../widgets/icons/circular_icon.dart';

class AppProductCardVertical extends StatelessWidget {
  const AppProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final thumb = product.imageUrls.isNotEmpty ? product.imageUrls.first : null;
    final wishlist = WishlistController.instance;

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withValues(alpha: 0.01),
              blurRadius: 50,
              spreadRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRoundedContainer(
              height: 160,
              padding: EdgeInsets.zero,
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  /// Force image to fit full container width/height
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.productImageRadius),
                      topRight: Radius.circular(AppSizes.productImageRadius),
                    ),
                    child: SizedBox.expand(
                      child: (thumb != null)
                          ? AppRoundedImage(
                        imageUrl: thumb,
                        isNetworkImage: true,
                        applyImageRadius: false,
                        borderRadius: AppSizes.productImageRadius,
                        fit: BoxFit.cover,
                      )
                          : const Center(child: Icon(Iconsax.image, size: 40)),
                    ),
                  ),

                  /// HEART ICON (wishlist toggle)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: StreamBuilder<bool>(
                      stream: wishlist.isWishlistedStream(product.id),
                      builder: (context, snap) {
                        final isFav = snap.data ?? false;

                        return AppCircularIcon(
                          width: 40,
                          height: 40,
                          icon: isFav ? Iconsax.heart5 : Iconsax.heart,
                          color: isFav ? Colors.red : Colors.redAccent.shade700,
                          onPressed: () async {
                            await wishlist.toggle(product.id, currentlyWishlisted: isFav);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems / 2),

            /// TEXT AREA
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.xs, right: AppSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppProductTitleText(title: product.title, smallSize: false),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),

                  Row(
                    children: [
                      const Icon(Icons.person, size: 14, color: AppColors.darkerGrey),
                      const SizedBox(width: AppSizes.xs),
                      Expanded(child: AppProductTitleText(title: product.sellerName, smallSize: true, maxLines: 1,)),
                    ],
                  ),

                  const SizedBox(height: AppSizes.xs),

                  AppProductTitleText(title: "Rs ${product.price.toStringAsFixed(0)}", smallSize: true,),
                  const SizedBox(height: AppSizes.xs),

                  Row(
                    children: [
                      const Icon(Iconsax.location, size: 14, color: AppColors.darkerGrey),
                      const SizedBox(width: AppSizes.xs),
                      Expanded(
                        child: Text(product.location, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkerGrey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}