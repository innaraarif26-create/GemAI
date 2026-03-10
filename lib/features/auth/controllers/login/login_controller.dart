import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/network_manager.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/data/repositories_authentication/authentication/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController{

  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    super.onInit();
  }

  /// --
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      AppFullScreenLoader.openLoadingDialog("Logging you in ...", AppImages.docerAnimation);

   /// Check Internet Connection
    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected)
    {
    AppFullScreenLoader.stopLoading();
    AppLoaders.warningSnackBar(
      title: "No Internet",
      message: "Please check your internet connection.",
    );
    return;
    }

    /// Form Validation
    if(!loginFormKey.currentState!.validate())
    {
    AppFullScreenLoader.stopLoading();
    return;
    }

    // Save Data if Remember Me is Selected
    if(rememberMe.value)
      {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

    // Login user using Email and Password Authentication
      final userCredentials = await AuthenticationRepository.instance.loginWIthEmailAndPassword(email.text.trim(), password.text.trim());

    // Remove Loader
      AppFullScreenLoader.stopLoading();

    // Redirect
    AuthenticationRepository.instance.screenRedirect();
   } catch (e)
    {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      AppFullScreenLoader.openLoadingDialog('Logging you in...', AppImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // Sign In with Google
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      /// USER CANCELLED GOOGLE LOGIN
      if (userCredentials == null) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      final userController = Get.put(UserController());
      // Save Authenticated user data in the Firebase Firestore
      await userController.saveUserRecord(userCredentials);
      // Remove Loader
      AppFullScreenLoader.stopLoading();

      // Redirect
      await AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

}