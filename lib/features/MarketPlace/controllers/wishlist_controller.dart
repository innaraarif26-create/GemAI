import 'package:get/get.dart';
import '../../../data/repositories/product/wishlist_repository.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final repo = WishlistRepository.instance;

  Stream<bool> isWishlistedStream(String productId) => repo.isWishlistedStream(productId);

  Future<void> toggle(String productId, {required bool currentlyWishlisted}) async {
    await repo.toggle(productId, currentlyWishlisted: currentlyWishlisted);
  }
}