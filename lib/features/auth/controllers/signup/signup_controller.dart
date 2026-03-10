import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/data/repositories_authentication/authentication/authentication_repository.dart';
import 'package:gemai/features/auth/screens/signup/verify_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helpers/network_manager.dart';
import '../../../../data/repositories_authentication/user/user_repository.dart';
import '../../../personalization/models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final privacyPolicy = true.obs;

  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// SIGNUP
  Future<void> signup() async {
    try {
      // Start Loading
      AppFullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.docerAnimation);

      // Check Internet Connection
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        AppFullScreenLoader.stopLoading();
        AppLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your internet connection.",
        );
        return;
      }

      // Form Validation
      if (!(signupFormKey.currentState?.validate() ?? false)) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        AppFullScreenLoader.stopLoading();
        AppLoaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message: "In order to create account, you must read and accept the Privacy Policy & Terms of Use.",
        );
        return;
      }

      // Register user in Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Save Authentication user data in Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
      );

      final userRepository = UserRepository.instance;
      await userRepository.saveUserRecord(newUser);

      // Remove loader
      AppFullScreenLoader.stopLoading();

      // Show success message
      AppLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your account has been created! Verify email to continue.",
      );

      // Navigate to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Show some Generic Error to the user
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}