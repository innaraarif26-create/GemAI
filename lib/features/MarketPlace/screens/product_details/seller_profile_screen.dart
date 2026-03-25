import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/product_detail.dart';

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
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String formatMonthYear(DateTime? date) {
    if (date == null) return "N/A";
    final month = (date.month >= 1 && date.month <= 12)
        ? _monthNames[date.month - 1]
        : date.month.toString();
    return "$month ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('sellerId', isEqualTo: sellerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
            } else {
              memberSince = null;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: sellerImageUrl != null
                        ? NetworkImage(sellerImageUrl!)
                        : null,
                    child: sellerImageUrl == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    sellerName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 8),
                Center(child: Text("Location: $sellerLocation")),
                const SizedBox(height: 8),
                Center(
                  child: Text("Member since: ${formatMonthYear(memberSince)}"),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  "Uploaded Products",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (products.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text("No products uploaded yet."),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, i) {
                      final product = products[i];
                      final created = product.createdAt;
                      final createdMonthYear = formatMonthYear(created);

                      return ListTile(
                        leading: product.imageUrls.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            product.imageUrls.first,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                            const Icon(Icons.broken_image, size: 56),
                          ),
                        )
                            : const Icon(Icons.image, size: 56),
                        title: Text(product.title),
                        subtitle: Text(
                            "Price: \$${product.price.toStringAsFixed(2)}\nLocation: ${product.location}\nUploaded: $createdMonthYear"),
                        isThreeLine: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
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