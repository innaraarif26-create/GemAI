import 'package:gemai/features/auth/screens/password_configuration/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../login/login_screen.dart';

class ForgetPassword extends StatelessWidget
{
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.off(()=>LoginScreen()),
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFB48B54), size: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            /// Icon
            Icon(Icons.lock_reset_rounded,size: 80,color: Color(0xFFB48B54),),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            /// Heading
            Text(AppTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text(AppTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
            const SizedBox(height: AppSizes.spaceBtwSections,),

            /// Text Field
            TextFormField(
              decoration: InputDecoration(
                labelText: AppTexts.email,prefixIcon: Icon(Iconsax.direct_right,size:20,),),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections,),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () =>
                Get.off(() => const ResetPassword()),
              child: Text(AppTexts.submit)),
            )
          ],
        ),
      ),
    );
  }
}
