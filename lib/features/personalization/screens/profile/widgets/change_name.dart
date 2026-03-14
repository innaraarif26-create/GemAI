import 'package:flutter/material.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/validators/validation.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/text.dart';
import '../../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context)
  {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppAppBar(showBackArrow: true,title: Text("Change Name",style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text("Use real name for easy verification. This name will appear on several pages.",style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: AppSizes.spaceBtwSections,),

            /// Form Text field and Button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => AppValidator.validateEmptyText("First Name", value),
                    expands: false,
                    decoration: const InputDecoration(labelText: AppTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields,),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => AppValidator.validateEmptyText("Last Name", value),
                    expands: false,
                    decoration: const InputDecoration(labelText: AppTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections,),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text("Save")),
            )
          ],
        ),
      ),
    );
  }
}
