
import 'package:GemAI/core/constants/image_strings.dart';
import 'package:GemAI/core/utils/popups/full_screen_loader.dart';
import 'package:GemAI/core/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helpers/network_manager.dart';

class SignupController extends GetxController
{
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// SIGNUP
  Future<void> signup() async
  {
    try {
      // Start Loading
      AppFullScreenLoader.openLoadingDialog("We are processing your information", AppImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      // Form Validation
      if(signupFormKey.currentState!.validate()) return;


      // Privacy Policy Check

      // Register user in the Firebase Authentication and Save User data in the Firebase

      // Save Authentication user data in the Firebase Firestore

      // show success Message

      // Move to Verify Email Screen
    } catch (e) {
      // Show some Generic Error to the user
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    } finally {
      // Remove Loader
      AppFullScreenLoader.stopLoading();
    }
  }
}