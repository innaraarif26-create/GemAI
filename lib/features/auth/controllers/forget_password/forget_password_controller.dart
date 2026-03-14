import 'package:flutter/cupertino.dart';
import 'package:gemai/core/utils/helpers/network_manager.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../../core/constants/image_strings.dart';
import '../../screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  Future<void> sendPasswordResetEmail() async {
    try {
      AppFullScreenLoader.openLoadingDialog("Processing your request...", AppImages.docerAnimation);

      /// Check Internet Connection
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      /// Send Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      /// Remove loader
      AppFullScreenLoader.stopLoading();

      /// Success message
      AppLoaders.successSnackBar(title: "Email Sent", message: "Email link sent to Reset your Password".tr);

      /// Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  /// Resend Reset Password Email
  Future<void> resendPasswordResetEmail(String email) async {
    try {
      AppFullScreenLoader.openLoadingDialog("Processing your request...", AppImages.docerAnimation);

      /// Check Internet Connection
      final bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      /// Send Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      /// Remove loader
      AppFullScreenLoader.stopLoading();

      /// Success message
      AppLoaders.successSnackBar(title: "Email Sent", message: "Email link sent to Reset your Password".tr);
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}