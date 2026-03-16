import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/controllers/product_controller.dart';
import 'package:gemai/features/MarketPlace/controllers/wishlist_controller.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import '../../../../widgets/layouts/grid_layout.dart';
import '../all_products/all_products.dart';
import '../listing/create_listing_screen.dart';
import '../product_details/widgets/product_card_vertical.dart';
import '../wishlist/favorite_icon.dart';
import '../wishlist/wishlist.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final wishlist = WishlistController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppAppBar(
        title: Text("Store", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          StreamBuilder<int>(
            stream: wishlist.wishlistCountStream(),
            builder: (context, snap) {
              final count = snap.data ?? 0;

              return AppFavoriteCounterIcon(
                count: count,
                iconColor: dark ? AppColors.white : AppColors.black,
                onPressed: () => Get.to(const FavouriteScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () => Get.to(() => const CreateListingScreen()),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
        child: Column(
          children: [
            AppSearchContainer(text: "Search in store", showBackground: false),
            const SizedBox(height: AppSizes.spaceBtwSections),
            AppSectionHeading(
              title: "Popular Products",
              showActionButton: true,
              onPressed: () => Get.to(() => const AllProducts()),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            StreamBuilder(
              stream: controller.popularStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");

                final items = snapshot.data ?? [];
                if (items.isEmpty) return const Text("No products yet.");

                return AppGridLayout(
                  itemCount: items.length,
                  itemBuilder: (_, index) => AppProductCardVertical(product: items[index]),
                );
              },
            ),
            const SizedBox(height: AppSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}