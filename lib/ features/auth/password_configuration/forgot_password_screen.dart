import 'package:flutter/material.dart';
import 'package:gemai/%20features/auth/password_configuration/reset_password.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget
{
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(AppTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: AppSizes.spaceBtwItems,),
            Text(AppTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: AppSizes.spaceBtwSections*2,),

            /// Text Field
            TextFormField(
              decoration: InputDecoration(
                labelText: AppTexts.email,prefixIcon: Icon(Iconsax.direct_right),),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections,),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () =>
                Get.to(() => const ResetPassword()),
              child: Text(AppTexts.submit)),
            )
          ],
        ),
      ),
    );
  }
}
