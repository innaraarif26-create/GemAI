import 'package:get/get.dart';
import '../core/utils/helpers/network_manager.dart';
import '../features/MarketPlace/controllers/product_controller.dart';
import '../features/MarketPlace/controllers/wishlist_controller.dart';
import '../features/auth/controllers/auth_controller.dart';
import '../features/personalization/controllers/user_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ProductController(), permanent: true);

    // keeps auth session state available everywhere
    Get.put(AuthController(), permanent: true);

    // user profile controller (we’ll make it wait for auth below)
    Get.put(UserController(), permanent: true);

    // wishlist toggle + wishlist streams
    Get.put(WishlistController(), permanent: true);
  }
}