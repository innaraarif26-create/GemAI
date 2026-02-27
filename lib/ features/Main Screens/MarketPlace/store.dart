import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GemAI/core/constants/colors.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/widgets/appbar/appbar.dart';
import 'package:GemAI/widgets/custom_shapes/containers/search_container.dart';
import 'package:GemAI/widgets/texts/section_heading.dart';
import '../../../widgets/Favorite_Products/favorite_icon.dart';
import '../../../widgets/Products/product_card/product_card_vertical.dart';
import '../../../widgets/layouts/grid_layout.dart';
import '../wishlist/wishlist.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: Text("Store", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          AppFavoriteCounterIcon(onPressed: () => Get.to(const FavouriteScreen()),iconColor: AppColors.black,),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
        child: Column(
          children: [

            /// Search Bar
            AppSearchContainer(text: "Search in store",showBackground: false,),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Popular Products
            AppSectionHeading(title: "Popular Products",showActionButton: true, onPressed: (){},),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// Grid Products
            AppGridLayout(itemCount: 6, itemBuilder: (_, index) => const AppProductCardVertical(),),
            const SizedBox(height: AppSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}