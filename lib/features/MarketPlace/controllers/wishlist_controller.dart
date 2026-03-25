import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/repositories/product/wishlist_repository.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final repo = WishlistRepository.instance;

  Stream<bool> isWishlistedStream(String productId) => repo.isWishlistedStream(productId);

  Future<void> toggle(String productId, {required bool currentlyWishlisted}) async {
    await repo.toggle(productId, currentlyWishlisted: currentlyWishlisted);
  }

  Stream<int> wishlistCountStream() {
    return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value(0);

      final wishRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Wishlist");

      return wishRef.snapshots().asyncMap((snap) async {
        final ids = snap.docs.map((d) => d.id).toList();

        if (ids.isEmpty) return 0;
        final limited = ids.take(100).toList();

        final productsSnap = await FirebaseFirestore.instance
            .collection("Products")
            .where(FieldPath.documentId, whereIn: limited)
            .get();

        return productsSnap.size;
      });
    });
  }
}