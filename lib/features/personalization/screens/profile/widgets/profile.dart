import 'package:flutter/material.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/shimmer/app_shimmer_effect.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../widgets/image_widget/circular_image.dart';
import '../../../controllers/user_controller.dart';
import 'change_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const AppAppBar(
        showBackArrow: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : AppImages.user;

                      return controller.imageUploading.value
                          ? const AppShimmerEffect(width: 80, height: 80, radius: 80)
                          : AppCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text("Change Profile Picture"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),
              const AppSectionHeading(title: "Profile Information", showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Reactive Profile Fields
              Obx(() => AppProfileMenu(
                title: "Name",
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              )),
              Obx(() => AppProfileMenu(
                title: "Username",
                value: controller.user.value.username,
                onPressed: () {},
              )),

              const SizedBox(height: AppSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              const AppSectionHeading(title: "Personal Information", showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Reactive personal info fields
              Obx(() => AppProfileMenu(
                title: "User ID",
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {},
              )),
              Obx(() => AppProfileMenu(
                title: "Email",
                value: controller.user.value.email,
                onPressed: () {},
              )),
              Obx(() => AppProfileMenu(
                title: "Phone Number",
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              )),
              AppProfileMenu(title: "Gender", value: "Male", onPressed: () {}),
              AppProfileMenu(title: "Date of Birth", value: "21 Aug, 2021", onPressed: () {}),

              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// Delete Account Button
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text("Delete Account", style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}