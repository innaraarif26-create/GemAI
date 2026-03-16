import 'package:get/get.dart';
import '../core/utils/helpers/network_manager.dart';
import '../features/MarketPlace/controllers/product_controller.dart';
import '../features/personalization/controllers/user_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ProductController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }
}