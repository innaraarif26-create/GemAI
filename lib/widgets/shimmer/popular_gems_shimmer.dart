import 'package:flutter/cupertino.dart';
import 'package:gemai/widgets/shimmer/app_shimmer_effect.dart';

import '../../core/constants/sizes.dart';

class AppPopularGemsShimmer extends StatelessWidget {
  const AppPopularGemsShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: AppSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              AppShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: AppSizes.spaceBtwItems / 2),

              // Text
              AppShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}