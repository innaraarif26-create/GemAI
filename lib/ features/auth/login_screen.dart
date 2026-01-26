import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget
{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(dark? AppImages.lightAppLogo : AppImages.darkAppLogo),
                  ),
                  Text(AppTexts.loginTitle, style: Theme.of(context).textTheme.bodyMedium,),
                  const SizedBox(height:  AppSizes.sm,),
                  Text(AppTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              /// Form
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
                  child: Column(
                  children: [
                    /// Email
                    TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right),labelText: AppTexts.email),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields,),

                    /// Password
                    TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check),labelText: AppTexts.password, suffixIcon: Icon(Iconsax.eye_slash)),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields / 2,),

                    /// Remember Me & Forget Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Remember Me
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value){}),
                            const Text(AppTexts.rememberMe),
                          ],
                        ),

                        /// Forget Password
                        TextButton(onPressed: (){}, child: const Text(AppTexts.forgetPassword)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections,),

                    /// Sign In Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text(AppTexts.signIn))),
                    const SizedBox(height:  AppSizes.spaceBtwItems,),
                    /// Create Account Button
                    SizedBox(width: double.infinity, child: OutlinedButton(onPressed: (){}, child: Text(AppTexts.createAccount))),
                    ],
                  ),
                ),
              ),
              /// Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Divider(color: dark ? AppColors.darkGrey : AppColors.grey, thickness: 0.5, indent: 60,endIndent: 5,)),
                  Text(AppTexts.orSignInWith.capitalize!, style: Theme.of(context).textTheme.labelMedium,),
                  Flexible(child: Divider(color: dark ? AppColors.darkGrey : AppColors.grey, thickness: 0.5, indent: 5,endIndent: 60,)),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
