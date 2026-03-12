import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../../data/repositories_authentication/gems/gems_repository.dart';
import '../../../../models/popular_gemstone_model.dart';

class GemsController extends GetxController {
  static GemsController get instance => Get.find();

  final gemsRepository = GemsRepository();
  RxList<GemDetailModel> allGems = <GemDetailModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchGems();
    super.onInit();
  }

  Future<void> fetchGems() async {
    try {
      // Show loader while loading popular gems
      isLoading.value = true;

      // Fetch popular gems from data source (Firestore, API, etc)
      final result = await gemsRepository.fetchGems();


      // Update the popular gems list
      allGems.assignAll(result);

    } catch (e) {
      AppLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());

    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}