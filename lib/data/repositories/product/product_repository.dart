import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/MarketPlace/models/product_model.dart';

class ProductRepository {
  ProductRepository._();
  static final ProductRepository instance = ProductRepository._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products => _db.collection("Products");

  Stream<List<ProductModel>> watchPopularMostViewed({int limit = 4}) {
    return _products
        .where("isActive", isEqualTo: true)
        .orderBy("views", descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map(ProductModel.fromSnapshot).toList());
  }

  Stream<List<ProductModel>> watchAll({
    String search = "",
    String? category,
    String sortBy = "createdAt", // createdAt | views | price
    bool descending = true,
  }) {
    Query<Map<String, dynamic>> q = _products.where("isActive", isEqualTo: true);

    if (category != null && category.trim().isNotEmpty) {
      q = q.where("category", isEqualTo: category.trim());
    }

    q = q.orderBy(sortBy, descending: descending);

    // Firestore doesn't support contains search -> filter client-side
    return q.snapshots().map((snap) {
      var items = snap.docs.map(ProductModel.fromSnapshot).toList();
      final s = search.trim().toLowerCase();
      if (s.isEmpty) return items;

      return items.where((p) {
        return p.title.toLowerCase().contains(s) ||
            p.description.toLowerCase().contains(s) ||
            p.location.toLowerCase().contains(s) ||
            p.category.toLowerCase().contains(s);
      }).toList();
    });
  }

  Future<List<String>> uploadImages({
    required String sellerId,
    required String productId,
    required List<XFile> images,
  }) async {
    final storage = FirebaseStorage.instance;
    final List<String> urls = [];

    for (final img in images) {
      final fileName = "img_${DateTime.now().millisecondsSinceEpoch}_${img.name}";
      final ref = storage.ref("Products/$sellerId/$productId/$fileName");
      await ref.putFile(File(img.path)); // mobile OK
      urls.add(await ref.getDownloadURL());
    }

    return urls;
  }

  Future<String> createProduct({
    required ProductModel product,
  }) async {
    final doc = _products.doc(product.id);
    await doc.set(product.toJson());
    return doc.id;
  }

  String newProductId() => _products.doc().id;

  Future<void> incrementViews(String productId) async {
    await _products.doc(productId).update({"views": FieldValue.increment(1)});
  }
}