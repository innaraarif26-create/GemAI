import 'package:flutter/material.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/edit_personal_info_screen.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/shimmer/app_shimmer_effect.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../widgets/image_widget/circular_image.dart';
import '../../controllers/user_controller.dart';
import 'widgets/change_name.dart';

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
                      child: const Text("Change Profile Picture",style: TextStyle(color: AppColors.buttonSecondary),),
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
                onPressed: () => Get.to(() => const EditPersonalInfoScreen(fieldType: 'username'),
                ),
              )),

              const SizedBox(height: AppSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              const AppSectionHeading(title: "Personal Information", showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              /// User ID - Click to copy (no navigation for userid)
              Obx(() => AppProfileMenu(
                title: "User ID",
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {
                  _showUserIdDialog(context, controller.user.value.id);
                },
              )),

              /// Email
              Obx(() => AppProfileMenu(
                title: "Email",
                value: controller.user.value.email,
                onPressed: () => Get.to(() => const EditPersonalInfoScreen(fieldType: 'email'),
                ),
              )),

              /// Phone Number
              Obx(() => AppProfileMenu(
                title: "Phone Number",
                value: controller.user.value.phoneNumber,
                onPressed: () => Get.to(
                      () => const EditPersonalInfoScreen(fieldType: 'phone'),
                ),
              )),

              /// Gender
              Obx(() => AppProfileMenu(
                title: "Gender",
                value: controller.user.value.gender.isEmpty
                    ? "Not Set"
                    : controller.user.value.gender,
                onPressed: () => Get.to(
                      () => const EditPersonalInfoScreen(fieldType: 'gender'),
                ),
              )),

              /// Date of Birth
              Obx(() => AppProfileMenu(
                title: "Date of Birth",
                value: controller.user.value.dateOfBirth.isEmpty
                    ? "Not Set"
                    : controller.user.value.dateOfBirth,
                onPressed: () => Get.to(
                      () => const EditPersonalInfoScreen(fieldType: 'dob'),
                ),
              )),

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

  /// Dialog to show User ID with copy option
  void _showUserIdDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your User ID"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade50,
              ),
              child: SelectableText(
                userId,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}