import 'package:gemai/core/utils/validators/validation.dart';
import 'package:gemai/features/auth/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AppValidator.validateEmptyText("First name", value),
                  decoration: const InputDecoration(
                    labelText: AppTexts.firstName,
                    prefixIcon: Icon(Iconsax.user, size: 20),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AppValidator.validateEmptyText("Last name", value),
                  decoration: const InputDecoration(
                    labelText: AppTexts.lastName,
                    prefixIcon: Icon(Iconsax.user, size: 20),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                AppValidator.validateEmptyText("User name", value),
            decoration: const InputDecoration(
              labelText: AppTexts.userName,
              prefixIcon: Icon(Iconsax.user_edit, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: AppTexts.email,
              prefixIcon: Icon(Iconsax.direct, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Phone
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) =>
                AppValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: AppTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call, size: 20),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Password
          Obx(
                () => TextFormField(
              controller: controller.password,
              validator: (value) =>
                  AppValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: AppTexts.password,
                prefixIcon:
                const Icon(Iconsax.password_check, size: 20),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields),

          /// Confirm Password
          Obx(
                () => TextFormField(
              controller: controller.confirmPassword,
              validator: (value) =>
                  AppValidator.validateConfirmPassword(
                      controller.password.text, value),
              obscureText:
              controller.hideConfirmPassword.value,
              decoration: InputDecoration(
                labelText: AppTexts.confirmPassword,
                prefixIcon:
                const Icon(Iconsax.password_check, size: 20),
                suffixIcon: IconButton(
                  onPressed: () => controller
                      .hideConfirmPassword.value =
                  !controller.hideConfirmPassword.value,
                  icon: Icon(
                    controller.hideConfirmPassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.defaultSpace),

          /// Terms & Conditions (🔥 FIXED HERE)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Obx(
                      () => Checkbox(
                    value: controller.privacyPolicy.value,
                    onChanged: (value) =>
                    controller.privacyPolicy.value =
                    !controller.privacyPolicy.value,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),

              /// 🔥 THIS FIXES OVERFLOW
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppTexts.iAgreeTo,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                      TextSpan(
                        text: AppTexts.privacyPolicy,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(
                          color: AppColors.accent,
                          decoration:
                          TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: AppTexts.and,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                      TextSpan(
                        text: AppTexts.termOfUse,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(
                          color: AppColors.accent,
                          decoration:
                          TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.defaultSpace),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.signup,
              child: const Text(AppTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
