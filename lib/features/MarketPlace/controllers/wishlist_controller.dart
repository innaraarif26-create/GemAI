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

  /// realtime count for appbar badge
  Stream<int> wishlistCountStream() {
    return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
      if (user == null) {
        return Stream.value(0);
      }

      return FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Wishlist")
          .snapshots()
          .map((snap) => snap.size);
    });
  }
}