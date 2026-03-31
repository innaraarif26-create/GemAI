import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/product_detail.dart';
import 'package:get/get.dart';

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({
    super.key,
    required this.sellerId,
    required this.sellerName,
    this.sellerImageUrl,
    required this.sellerLocation,
  });

  final String sellerId;
  final String sellerName;
  final String? sellerImageUrl;
  final String sellerLocation;

  static const List<String> _monthNames = [
    'January','February','March','April','May','June',
    'July','August','September','October','November','December'
  ];

  String formatMonthYear(DateTime? date) {
    if (date == null) return "N/A";
    final month = _monthNames[date.month - 1];
    return "$month ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    final bgColor = dark ? Colors.black : Colors.white;
    final cardColor = dark ? Colors.grey[900]! : Colors.grey[100]!;
    final textColor = dark ? Colors.white : Colors.black;
    final subTextColor = dark ? Colors.grey[300]! : Colors.grey[700]!;
    final dividerColor = dark ? Colors.grey[700]! : Colors.grey[300]!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "User Profile",
          style: TextStyle(color: textColor),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: textColor,
            size: 20,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('sellerId', isEqualTo: sellerId)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: textColor),
              ),
            );
          }

          List<ProductModel> products = [];
          DateTime? memberSince;

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            products = snapshot.data!.docs
                .map((doc) => ProductModel.fromSnapshot(doc))
                .toList();

            final dates = snapshot.data!.docs
                .map((d) => (d.data()['createdAt'] as Timestamp?)?.toDate())
                .where((d) => d != null)
                .cast<DateTime>()
                .toList();

            if (dates.isNotEmpty) {
              dates.sort();
              memberSince = dates.first;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// PROFILE IMAGE
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor:
                    dark ? Colors.grey[800] : Colors.grey[300],
                    backgroundImage:
                    sellerImageUrl != null ? NetworkImage(sellerImageUrl!) : null,
                    child: sellerImageUrl == null
                        ? Icon(Icons.person,
                        size: 50, color: subTextColor)
                        : null,
                  ),
                ),

                const SizedBox(height: 16),

                /// NAME
                Center(
                  child: Text(
                    sellerName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: textColor),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Location: $sellerLocation",
                    style: TextStyle(color: subTextColor),
                  ),
                ),
                const SizedBox(height: 8),

                Center(
                  child: Text(
                    "Member since: ${formatMonthYear(memberSince)}",
                    style: TextStyle(color: subTextColor),
                  ),
                ),

                const SizedBox(height: 24),

                Divider(color: dividerColor),

                const SizedBox(height: 16),

                /// PRODUCTS TITLE
                Text(
                  "Uploaded Products",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: textColor),
                ),

                const SizedBox(height: 8),

                /// LOADING
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  )

                /// NO PRODUCTS
                else if (products.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "No products uploaded yet.",
                      style: TextStyle(color: subTextColor),
                    ),
                  )

                /// PRODUCT LIST
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    separatorBuilder: (_, _) =>
                        Divider(color: dividerColor),

                    itemBuilder: (context, i) {
                      final product = products[i];
                      final createdMonthYear =
                      formatMonthYear(product.createdAt);

                      return Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: product.imageUrls.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.imageUrls.first,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                              const Icon(Icons.broken_image),
                            ),
                          )
                              : Icon(Icons.image, color: subTextColor),

                          title: Text(
                            product.title,
                            style: TextStyle(color: textColor),
                          ),

                          subtitle: Text(
                            "Price: \$${product.price.toStringAsFixed(2)}"
                                "\nLocation: ${product.location}"
                                "\nUploaded: $createdMonthYear",
                            style: TextStyle(color: subTextColor),
                          ),

                          isThreeLine: true,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}