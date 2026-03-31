import 'package:flutter/cupertino.dart';
import 'package:gemai/core/utils/helpers/network_manager.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/data/repositories/user/user_repository.dart';
import 'package:gemai/features/personalization/controllers/user_controller.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/profile.dart';
import 'package:get/get.dart';

import '../../../core/constants/image_strings.dart';

class UpdatePersonalInfoController extends GetxController {
  static UpdatePersonalInfoController get instance => Get.find();

  final gender = TextEditingController();
  final dateOfBirth = TextEditingController();
  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  GlobalKey<FormState> updatePersonalInfoFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializePersonalInfo();
    super.onInit();
  }

  Future<void> initializePersonalInfo() async {
    gender.text = userController.user.value.gender;
    dateOfBirth.text = userController.user.value.dateOfBirth;
  }

  Future<void> updatePersonalInfo() async {
    try {
      AppFullScreenLoader.openLoadingDialog("We are updating your information...", AppImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!updatePersonalInfoFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> personalInfo = {
        "Gender": gender.text.trim(),
        "DateOfBirth": dateOfBirth.text.trim(),
      };
      await userRepository.updateSingleField(personalInfo);

      userController.user.value.gender = gender.text.trim();
      userController.user.value.dateOfBirth = dateOfBirth.text.trim();

      AppFullScreenLoader.stopLoading();

      AppLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your personal information has been updated.",
      );

      Get.off(() => const ProfileScreen());
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}