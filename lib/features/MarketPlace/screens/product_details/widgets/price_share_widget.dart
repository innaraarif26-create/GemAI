import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_price_text.dart';
import '../../../../../core/constants/sizes.dart';

class AppPriceAndShare extends StatelessWidget {
  const AppPriceAndShare({
    super.key,
    required this.price,
    required this.title,
    required this.location,
    required this.productId,
  });

  final double price;
  final String title;
  final String location;
  final String productId;

  void _shareProduct() {
    final String productLink = 'https://yourdomain.com/products/$productId';

    final String shareText = '''
Check out this product on GemAI

$title
Price: \$${price.toStringAsFixed(0)}
Location: $location

View product:
$productLink
''';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Price
        Row(
          children: [
            AppProductPriceText(price: price.toStringAsFixed(0)),
          ],
        ),

        /// Share Button
        IconButton(
          onPressed: _shareProduct,
          icon: const Icon(Icons.share_outlined, size: AppSizes.iconMd),
        ),
      ],
    );
  }
}