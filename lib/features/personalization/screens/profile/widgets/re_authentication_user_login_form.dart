import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/constants/text.dart';
import '../../../../../core/utils/validators/validation.dart';
import '../../../controllers/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: AppValidator.validateEmail,
                  decoration: InputDecoration(prefixIcon: const Icon(Iconsax.direct_right), labelText: AppTexts.email),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),

                /// Password
                Obx(
                      () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) => AppValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      labelText: AppTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon:  Icon(controller.hidePassword.value ? Iconsax.eye : Iconsax.eye_slash),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// LOGIN Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPassword(), child: const Text('Verify')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
