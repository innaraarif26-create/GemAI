import 'package:flutter/material.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_price_text.dart';
import '../../../../../core/constants/sizes.dart';

class AppPriceAndShare extends StatelessWidget {
  const AppPriceAndShare({super.key, required this.price});

  final double price;

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
          onPressed: () {},
          icon: const Icon(Icons.share_outlined, size: AppSizes.iconMd),
        )
      ],
    );
  }
}