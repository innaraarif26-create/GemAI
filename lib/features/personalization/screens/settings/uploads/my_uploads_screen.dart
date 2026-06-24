import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/models/product_model.dart';
import 'package:gemai/features/personalization/screens/settings/uploads/edit_upload_screen.dart';
import 'package:gemai/features/personalization/screens/settings/uploads/widgets/product_upload_card.dart';
import 'package:get/get.dart';

class MyUploadsScreen extends StatefulWidget {
  const MyUploadsScreen({super.key});

  @override
  State<MyUploadsScreen> createState() => _MyUploadsScreenState();
}

class _MyUploadsScreenState extends State<MyUploadsScreen> {
  List<ProductModel> _products = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUploads();
  }

  Future<void> _fetchUploads() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        setState(() {
          _error = "Please log in to view your uploads.";
          _loading = false;
        });
        return;
      }

      final snap = await FirebaseFirestore.instance
          .collection("Products")
          .where("sellerId", isEqualTo: uid)
          .orderBy("createdAt", descending: true)
          .get();

      final items = snap.docs.map(ProductModel.fromSnapshot).toList();
      setState(() {
        _products = items;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load uploads. Please try again.";
        _loading = false;
      });
    }
  }

  Future<void> _confirmDelete(ProductModel product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Listing"),
        content: Text('Are you sure you want to delete "${product.title}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await _deleteProduct(product);
  }

  Future<void> _deleteProduct(ProductModel product) async {
    try {
      // Delete all images from Firebase Storage
      for (final url in product.imageUrls) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(url);
          await ref.delete();
        } catch (_) {
          // Ignore individual image deletion errors
        }
      }

      // Delete Firestore document
      await FirebaseFirestore.instance.collection("Products").doc(product.id).delete();

      setState(() => _products.removeWhere((p) => p.id == product.id));
      Get.snackbar("Deleted", '"${product.title}" has been removed.');
    } catch (e) {
      Get.snackbar("Error", "Could not delete the listing. Please try again.");
    }
  }

  Future<void> _editProduct(ProductModel product) async {
    final updated = await Get.to(() => EditUploadScreen(product: product));
    if (updated == true) {
      _fetchUploads();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Uploads"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchUploads,
            tooltip: "Refresh",
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 60, color: AppColors.error),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwItems),
              ElevatedButton(onPressed: _fetchUploads, child: const Text("Retry")),
            ],
          ),
        ),
      );
    }

    if (_products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.upload_file_outlined, size: 80, color: Colors.grey.shade400),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                "No Uploads Yet",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                "Products you list for sale will appear here.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchUploads,
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.spaceBtwItems,
          mainAxisSpacing: AppSizes.spaceBtwItems,
          childAspectRatio: 0.62,
        ),
        itemCount: _products.length,
        itemBuilder: (_, index) {
          final product = _products[index];
          return ProductUploadCard(
            product: product,
            onEdit: () => _editProduct(product),
            onDelete: () => _confirmDelete(product),
          );
        },
      ),
    );
  }
}
