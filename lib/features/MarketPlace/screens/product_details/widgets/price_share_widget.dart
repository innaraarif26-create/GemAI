import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_price_text.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../widgets/icons/circular_icon.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../../models/product_model.dart';

class AppPriceAndShare extends StatelessWidget {
  const AppPriceAndShare({
    super.key,
    required this.price,
    required this.title,
    required this.location,
    required this.productId,
    required this.product,
  });

  final double price;
  final String title;
  final String location;
  final String productId;
  final ProductModel product;

  void _shareProduct() {
    final String productLink = 'https://gemai.com/products/$productId';

    final String shareText = '''Check out this product on GemAI
    $title
    Price: \$${price.toStringAsFixed(0)}
    Location: $location
    View product:
    $productLink ''';

    SharePlus.instance.share(ShareParams(text: shareText),);
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Price at the start
        AppProductPriceText(price: price.toStringAsFixed(0)),

        /// Icons at the end
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<bool>(
              stream: wishlist.isWishlistedStream(product.id),
              builder: (context, snap) {
                final isFav = snap.data ?? false;

                return AppCircularIcon(
                  width: 40,
                  height: 40,
                  icon: isFav ? Icons.favorite: Icons.favorite_border,size: AppSizes.iconMd,
                  color: isFav ? Colors.red : Colors.black,
                  onPressed: () async {
                    await wishlist.toggle(
                      product.id,
                      currentlyWishlisted: isFav,
                    );
                  },
                );
              },
            ),
            const SizedBox(width: 2),
            IconButton(
              onPressed: _shareProduct,
              icon: const Icon(Icons.share_outlined, size: AppSizes.iconMd,color: Colors.black,),
            ),
          ],
        ),
      ],
    );
  }
}