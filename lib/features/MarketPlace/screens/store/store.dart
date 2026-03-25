import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/controllers/product_controller.dart';
import 'package:gemai/features/MarketPlace/controllers/wishlist_controller.dart';
import 'package:gemai/features/MarketPlace/controllers/message_controller.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../widgets/layouts/grid_layout.dart';
import '../all_products/all_products.dart';
import '../chat/messages_screen.dart';
import '../listing/create_listing_screen.dart';
import '../product_details/widgets/product_card_vertical.dart';
import '../wishlist/favorite_icon.dart';
import '../wishlist/wishlist.dart';
import 'package:gemai/data/repositories/chat/chat_repository.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final wishlist = WishlistController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);
    final iconColor = dark ? AppColors.white : AppColors.black;

    return Scaffold(
      appBar: AppAppBar(
        title: Text("Store", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          StreamBuilder<int>(
            stream: MessageController.instance.unreadSendersCountStream(),
            builder: (context, snap) {
              final count = snap.data ?? 0;

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final uid = FirebaseAuth.instance.currentUser?.uid;
                        if (uid == null) {
                          Get.snackbar(
                            'Not signed in',
                            'Please sign in to view your messages.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black87,
                            colorText: Colors.white,
                          );
                          return;
                        }
                        final chatRepo = ChatRepo(FirebaseFirestore.instance, FirebaseStorage.instance);

                        Get.to(() => MessagesScreen(currentUserId: uid, repo: chatRepo,));
                      },
                      icon: Icon(Iconsax.messages4, color: iconColor),
                      tooltip: 'Messages',
                    ),
                    if (count > 0)
                      Positioned(
                        right: 4,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: dark ? Colors.black : Colors.white, width: 1),
                          ),
                          constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                          child: Center(
                            child: Text(
                              count > 99 ? '99+' : '$count',
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          StreamBuilder<int>(
            stream: wishlist.wishlistCountStream(),
            builder: (context, snap) {
              final count = snap.data ?? 0;

              return AppFavoriteCounterIcon(
                count: count,
                iconColor: iconColor,
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