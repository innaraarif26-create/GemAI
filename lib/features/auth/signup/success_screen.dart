import 'package:flutter/material.dart';
import 'package:GemAI/features/auth/login/login_screen.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/core/constants/text.dart';
import 'package:GemAI/core/constants/image_strings.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget
{
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
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
              /// Image
              Image(image: AssetImage(AppImages.emailVerified),width: AppHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              /// Title and Sub title
              Text(AppTexts.yourAccountCreatedTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text(AppTexts.yourAccountCreatedSubTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwSections,),
              /// Buttons
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Get.offAll(() => LoginScreen()), child: const Text('Continue')),)
            ],
          ),
        ),
      ),
    );
  }
}
