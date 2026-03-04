import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/features/auth/screens/signup/success_screen.dart';
import 'package:get/get.dart';

import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';

class VerifyEmailController extends GetxController
{
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever Verify Screen appears & set Timer for auto redirect
  @override
   void onInit()
  {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification Link
  Future<void> sendEmailVerification() async
  {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      AppLoaders.successSnackBar(title: "Email Sent",message: "Please Check your inbox and verify your email.");
    } catch (e) {
     AppLoaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
    }
  }
  /// Timer to automatically redirect on Email Verification
  void setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false)
        {
          timer.cancel();
          Get.off(()=> SuccessScreen(
            image:AppImages.successfullyRegisterAnimation,
            title: AppTexts.yourAccountCreatedTitle,
            subTitle: AppTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
        }
    });
  }
  /// Manually Check if Email Verified
  Future<void> checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified)
      {
        Get.off(
            () => SuccessScreen(
                image: AppImages.successfullyRegisterAnimation,
                title: AppTexts.yourAccountCreatedTitle,
                subTitle: AppTexts.yourAccountCreatedSubTitle,
                onPressed: () => AuthenticationRepository.instance.screenRedirect(),
            )
        );
      }
  }
}
