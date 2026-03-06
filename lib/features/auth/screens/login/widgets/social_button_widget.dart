import 'package:flutter/material.dart';
import 'package:gemai/features/auth/controllers/login/login_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';

class AppSocialButton extends StatelessWidget {

  const AppSocialButton({super.key});

  @override
  Widget build(BuildContext context)
  {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(100),),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              image: AssetImage(AppImages.google),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(100),),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              image: AssetImage(AppImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}