import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_card_vertical.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/icons/circular_icon.dart';
import 'package:gemai/widgets/layouts/grid_layout.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../navigation_menu.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  String get _uid {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw "User not logged in";
    return user.uid;
  }

  Stream<List<String>> _wishlistIdsStream() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(_uid)
        .collection("Wishlist")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.id).toList());
  }

  Stream<List<ProductModel>> _productsStreamByIds(List<String> ids) {
    if (ids.isEmpty) return Stream.value(<ProductModel>[]);

    // Firestore whereIn supports max 10 ids
    final limitedIds = ids.take(10).toList();

    return FirebaseFirestore.instance
        .collection("Products")
        .where(FieldPath.documentId, whereIn: limitedIds)
        .snapshots()
        .map((snap) {
      final products = snap.docs.map((d) => ProductModel.fromSnapshot(d)).toList();

      // Keep wishlist order
      final map = {for (final p in products) p.id: p};
      return limitedIds.map((id) => map[id]).whereType<ProductModel>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          AppCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const NavigationMenu()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: StreamBuilder<List<String>>(
            stream: _wishlistIdsStream(),
            builder: (context, wishSnap) {
              if (wishSnap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (wishSnap.hasError) return Text("Error: ${wishSnap.error}");

              final ids = wishSnap.data ?? [];
              if (ids.isEmpty) {
                return const Center(child: Text("No items in wishlist."));
              }

              return StreamBuilder<List<ProductModel>>(
                stream: _productsStreamByIds(ids),
                builder: (context, prodSnap) {
                  if (prodSnap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (prodSnap.hasError) return Text("Error: ${prodSnap.error}");

                  final products = prodSnap.data ?? [];
                  if (products.isEmpty) {
                    return const Center(child: Text("No products found."));
                  }

                  return Column(
                    children: [
                      AppGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => AppProductCardVertical(
                          product: products[index], // ✅ real ProductModel
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}