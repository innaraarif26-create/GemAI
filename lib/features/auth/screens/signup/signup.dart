import 'package:GemAI/features/auth/screens/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:GemAI/core/constants/colors.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/core/constants/text.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../core/constants/image_strings.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.off(()=>LoginScreen()),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(AppTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: AppSizes.defaultSpace),

              /// Form
              AppFormField(),
              const SizedBox(height: AppSizes.defaultSpace),
              /// Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Divider( color: dark  ? AppColors.darkGrey : AppColors.grey,thickness: 1,indent: 60, endIndent: 5,),),
                  Text(AppTexts.orSignUpWith.capitalize!, style:Theme.of(context).textTheme.labelMedium,),
                  Flexible(child: Divider( color: dark ? AppColors.darkGrey: AppColors.grey,thickness: 1, indent: 5,endIndent: 60,),),
                ],
              ),

              const SizedBox(height: AppSizes.defaultSpace),

              /// Footer (Social Login)
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


