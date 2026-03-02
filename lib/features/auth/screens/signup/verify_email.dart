import 'package:GemAI/features/auth/screens/signup/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GemAI/core/constants/image_strings.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/core/constants/text.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../login/login_screen.dart';

class VerifyEmailScreen extends StatelessWidget
{
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => Get.offAll(()=>LoginScreen()),icon: Icon(CupertinoIcons.clear),iconSize: 20,color: Color(0xFFB48B54))
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
              Text('tufailhyder21@gmail.com',style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text(AppTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwSections,),
              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.to(() => SuccessScreen()), child: Text('Continue'),),),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              SizedBox(width: double.infinity, child:  TextButton(onPressed: (){}, child: Text(AppTexts.resendEmail)),)
            ],
          ),
        ),
      ),
    );
  }
}
