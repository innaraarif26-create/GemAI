import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/auth/controllers/forget_password/forget_password_controller.dart';
import 'package:gemai/features/auth/screens/login/login_screen.dart';
import 'package:get/get.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/text.dart';
import 'forgot_password_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen ({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.off(() => ForgetPassword()),
            icon: const Icon(CupertinoIcons.clear),
            iconSize: 20,
            color: Color(0xFFB48B54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                /// Image
                Image(image: AssetImage(AppImages.emailVerified),width: AppHelperFunctions.screenWidth() * 0.6,),
                const SizedBox(height: AppSizes.spaceBtwItems,),

                /// Email Title and Sub title
                Text(email,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),
                const SizedBox(height: AppSizes.spaceBtwItems,),
                Text(AppTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
                const SizedBox(height: AppSizes.spaceBtwItems,),
                Text(AppTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
                const SizedBox(height: AppSizes.spaceBtwSections,),
                /// Buttons
                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Get.offAll(()=> const LoginScreen()), child: const Text('Done')),),
                const SizedBox(height: AppSizes.spaceBtwItems,),
                SizedBox(width: double.infinity,child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email) , child: const Text('Resend Email')),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
