import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/features/auth/screens/login/widgets/login_form.dart';
import 'package:gemai/features/auth/screens/login/widgets/social_button_widget.dart';
import 'package:gemai/navigation_menu.dart';
import 'package:get/get.dart';
import '../signup/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSizes.appBarHeight,
            bottom: AppSizes.defaultSpace,
            left: AppSizes.defaultSpace,
            right: AppSizes.defaultSpace,
          ),
          child: Column(
            children: [

              /// Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: 70,
                    image: AssetImage(
                      dark ? AppImages.darkAppLogo : AppImages.lightAppLogo,
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Text(
                    AppTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    AppTexts.loginSubTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),

              /// Form
              const AppLoginForm(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Create Account Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.off(() => const SignupScreen());
                  },
                  child: const Text(AppTexts.createAccount),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Continue as Guest
              TextButton(
                onPressed: () {
                  Get.to(() => const NavigationMenu());
                },
                child: Text("Continue as Guest", style: Theme.of(context).textTheme.bodySmall!.apply(color: AppColors.accent),
                ),
              ),

              const SizedBox(height: AppSizes.defaultSpace),

              /// Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? AppColors.darkGrey : AppColors.grey,
                      thickness: 1,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    AppTexts.orSignInWith.capitalize!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Flexible(
                    child: Divider(
                      color: dark ? AppColors.darkGrey : AppColors.grey,
                      thickness: 1,
                      indent: 5,
                      endIndent: 60,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.defaultSpace),

              /// Social Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(image: AppImages.google),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  SocialButton(image: AppImages.facebook),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

