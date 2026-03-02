import 'package:GemAI/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/auth/screens/login/login_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();

  /// called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Functions to show Relevant Screen
  screenRedirect() async {
    // Local Storage
    deviceStorage.writeIfNull("IsFirstTime", true);
    deviceStorage.read("IsFirstTime") != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(const OnboardingScreen());
  }

  /* ---------------------- Email And Password sign in ------------------- */

    /// [EmailAuthentication] - signIn

   /// [EmailAuthentication] - Register

   /// [ReAuthenticate] - ReAuthenticate User

   /// [EmailVerification] - Mail Verification

   /// [EmailAuthentication] - Forget Password

  /* ---------------------- Federated identity and social sign-in ------------------- */

   /// [GoogleAuthentication] - Google

   /// [FacebookAuthentication] - Facebook

  /* ---------------------- .end Federated identity & social sign-in ------------------- */

   /// [LogoutUser] - valid for any authentication.

   /// Delete User - Remove user Auth and Firestore Account



}
