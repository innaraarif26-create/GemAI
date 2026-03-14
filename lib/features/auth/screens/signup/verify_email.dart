import 'package:gemai/data/repositories/authentication/authentication_repository.dart';
import 'package:gemai/features/auth/controllers/signup/verify_email_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../widgets/appbar/appbar.dart';

class VerifyEmailScreen extends StatelessWidget
{
  const VerifyEmailScreen({super.key, this.email});

  final String? email;
  @override
  Widget build(BuildContext context)
  {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppAppBar(
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout() ,icon: Icon(CupertinoIcons.clear),iconSize: 20,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(image: AssetImage(AppImages.emailVerification),width: AppHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              /// Title and Sub title
              Text(AppTexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text(email ?? "",style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text(AppTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwSections,),
              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.checkEmailVerificationStatus(), child: const Text("Continue"))),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              SizedBox(width: double.infinity, child:  TextButton(onPressed: () => controller.sendEmailVerification(), child: Text(AppTexts.resendEmail)),)
            ],
          ),
        ),
      ),
    );
  }
}
