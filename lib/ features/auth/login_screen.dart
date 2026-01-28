import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
   }

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      /// Email
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right,size: 20,),
                          labelText: AppTexts.email,
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwInputFields),

                      /// Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          prefixIcon:const Icon(Iconsax.password_check,size: 20,),
                          labelText: AppTexts.password,
                          suffixIcon: IconButton(
                            icon: Icon( obscureText? Iconsax.eye_slash : Iconsax.eye, color: const Color(0xFFB48B54),size: 20,),
                            onPressed: () {
                              setState(()
                              {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: AppSizes.spaceBtwInputFields / 2,
                      ),

                      /// Remember Me & Forget Password
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(()
                                  {
                                    rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text(AppTexts.rememberMe),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child:const Text(AppTexts.forgetPassword,style: TextStyle(color: Color.fromARGB(255, 180, 139, 84),fontSize: 13, fontFamily: 'TimesRomanFont'),),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.defaultSpace),

                      /// Sign In Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(AppTexts.signIn),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      /// Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child:  const Text(AppTexts.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Divider( color: dark  ? AppColors.darkGrey : AppColors.grey,thickness: 1,indent: 60, endIndent: 5,),),
                  Text( AppTexts.orSignInWith.capitalize!, style:Theme.of(context).textTheme.labelMedium,),
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
