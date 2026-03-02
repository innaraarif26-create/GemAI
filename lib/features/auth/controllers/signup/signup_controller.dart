
import 'package:GemAI/core/constants/image_strings.dart';
import 'package:GemAI/core/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController
{
  static SignupController get instance => Get.find();

  /// Variables
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
      AppFullScreenLoader.openLoadingDialog("We are processing your information", AppImages.doco)
      // Check Internet Connection

      // Form Validation

      // Privacy Policy Check

      // Register user in the Firebase Authentication and Save User data in the Firebase

      // Save Authentication user data in the Firebase Firestore

      // show success Message

      //
    }
  }
}