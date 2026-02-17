import 'package:flutter/material.dart';
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
              Text("Rs 50000",style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        /// Share Button
        IconButton(onPressed: (){}, icon: const Icon(Icons.share_outlined,size: AppSizes.iconMd,))
      ],
    );
  }
}
