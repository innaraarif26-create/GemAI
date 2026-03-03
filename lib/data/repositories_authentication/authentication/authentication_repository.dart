import 'package:gemai/features/onboarding/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/exceptions/firebase_auth_exceptions.dart';
import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../core/utils/exceptions/format_exceptions.dart';
import '../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../features/auth/screens/login/login_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Functions to show Relevant Screen
  Future<void> screenRedirect() async {
    // Local Storage
    deviceStorage.writeIfNull("IsFirstTime", true);
    deviceStorage.read("IsFirstTime") != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(const OnboardingScreen());
  }

  /* ---------------------- Email And Password sign in ------------------- */

    /// [EmailAuthentication] - signIn

   /// [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Wrap it in an Exception object, not just String
      throw AppFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on FormatException {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception("Something went wrong. Please try again");
    }
  }

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
