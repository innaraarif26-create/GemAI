import 'package:flutter/material.dart';
import 'package:GemAI/features/auth/login/login_screen.dart';
import 'package:GemAI/features/auth/signup/verify_email.dart';
import 'package:GemAI/core/constants/colors.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/core/constants/text.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/image_strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscure = true;
  bool obscureConfirm = true;
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.off(()=>LoginScreen()),
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFB48B54), size: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                AppTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.defaultSpace),

              /// Form
              Form(
                child: Column(
                  children: [
                    /// First and Last Name
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(labelText: AppTexts.firstName,prefixIcon: Icon(Iconsax.user,size: 20),),
                          ),
                        ),
                    const SizedBox(width: AppSizes.spaceBtwInputFields,),
                    Expanded(
                        child: TextFormField(
                          expands: false,
                          decoration: const InputDecoration(labelText: AppTexts.lastName,prefixIcon: Icon(Iconsax.user,size: 20),),
                        )
                    )
                  ],
                ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields,),

                    /// UserName
                    TextFormField(
                      decoration: const InputDecoration(labelText: AppTexts.userName,prefixIcon: Icon(Iconsax.user_edit,size: 20)),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields,),

                    /// Email
                    TextFormField(
                      decoration: const InputDecoration(labelText: AppTexts.email,prefixIcon: Icon(Iconsax.direct,size: 20)),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields,),

                    /// Phone Number
                    TextFormField(
                      decoration: const InputDecoration(labelText: AppTexts.phoneNumber,prefixIcon: Icon(Iconsax.call,size: 20)),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields,),

                     /// Password
                    TextFormField(
                      obscureText: obscure,
                      decoration: InputDecoration(labelText: AppTexts.password,prefixIcon: const Icon(Iconsax.password_check,size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(obscure ? Iconsax.eye_slash : Iconsax.eye,size: 20),
                          onPressed: () {
                            setState(()
                            {
                              obscure= !obscure;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields,),

                    /// Confirm Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscureConfirm,
                      decoration: InputDecoration(labelText: AppTexts.confirmPassword,prefixIcon: const Icon(Iconsax.password_check,size: 20),
                        suffixIcon: IconButton(
                          icon: Icon( obscureConfirm  ? Iconsax.eye_slash : Iconsax.eye,size: 20),
                          onPressed: () {
                            setState(()
                            {
                              obscureConfirm = !obscureConfirm;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.defaultSpace),

                   /// Terms&Conditions
                   Row(
                     children: [
                       SizedBox(width: 24, height: 24,
                         child: Checkbox(
                           value: agree,
                           onChanged: (value) {
                             setState(()
                             {
                              agree = value ?? false;
                             });
                           },
                         ),
                       ),
                       const SizedBox(width: AppSizes.spaceBtwItems,),
                       Text.rich(
                         TextSpan(children: [
                         TextSpan(text: AppTexts.iAgreeTo,style: Theme.of(context).textTheme.bodySmall),
                         TextSpan(text: AppTexts.privacyPolicy, style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? AppColors.accent : AppColors.accent,
                         decoration: TextDecoration.underline,
                         decorationColor: dark ? AppColors.accent : AppColors.accent
                         )),
                         TextSpan(text: AppTexts.and,style: Theme.of(context).textTheme.bodySmall),
                           TextSpan(text: AppTexts.termOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? AppColors.accent : AppColors.accent,
                               decoration: TextDecoration.underline,
                               decorationColor: dark ? AppColors.accent : AppColors.accent
                           )),
                       ]),
                       ),
                     ],
                   ),
                   const SizedBox(height: AppSizes.defaultSpace,),
                   /// Sign Up Button
                   SizedBox(width: double.infinity,
                   child: ElevatedButton(
                       onPressed: () 
                       {
                         Get.off(VerifyEmailScreen());
                       },
                       child: Text(AppTexts.createAccount)),
                   )
                ],
              ),
            ),
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
                  _SocialButton(image: AppImages.google),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  _SocialButton(image: AppImages.facebook),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable social button
class _SocialButton extends StatelessWidget {
  final String image;

  const _SocialButton({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Image(
          width: AppSizes.iconMd,
          height: AppSizes.iconMd,
          image: AssetImage(image),
        ),
      ),
    );
  }
}

