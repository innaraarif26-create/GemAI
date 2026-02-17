import 'package:flutter/material.dart';
import 'package:gemai/%20features/shop/screens/product_details/widgets/product_price_text.dart';
import '../../../../../core/constants/sizes.dart';

class AppPriceAndShare extends StatelessWidget {
  const AppPriceAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Price
        Row(
          children: [
              AppProductPriceText(price: '50,000'),
          ],
        ),
        /// Share Button
        IconButton(onPressed: (){}, icon: const Icon(Icons.share_outlined,size: AppSizes.iconMd,))
      ],
    );
  }
}
