import 'package:flutter/material.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../widgets/image_widget/circular_image.dart';
import '../../../controllers/user_controller.dart';
import 'change_name.dart';

class ProfileScreen extends StatelessWidget
{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const AppAppBar(
        showBackArrow: true, title: Text("Profile"),
      ),
      /// Body
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
                    const AppCircularImage(image: AppImages.user,width: 80,height: 80,),
                    TextButton(onPressed: (){}, child: const Text("Change Profile Picture"))
                  ]
                ),
              ),
              /// Divider
               const SizedBox(height: AppSizes.spaceBtwItems / 2,),
               const Divider(),
               const SizedBox(height: AppSizes.spaceBtwItems,),
               const AppSectionHeading(title: "Profile Information", showActionButton: false),
               const SizedBox(height: AppSizes.spaceBtwItems,),
              
               AppProfileMenu(title: "Name", value:controller.user.value.fullName,onPressed: () => Get.to(() => const ChangeName())),
               AppProfileMenu(title: "Username", value:controller.user.value.username,onPressed: (){}),

              const SizedBox(height: AppSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              /// Heading OPersonal Info
              const AppSectionHeading(title: "Personal Information",showActionButton: false,),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              AppProfileMenu(onPressed: (){}, title: "User ID", value:controller.user.value.id,icon: Iconsax.copy,),
              AppProfileMenu(onPressed: (){}, title: "Email", value: controller.user.value.email),
              AppProfileMenu(onPressed: (){}, title: "Phone Number", value: controller.user.value.phoneNumber),
              AppProfileMenu(onPressed: (){}, title: "Gender", value: "Male"),
              AppProfileMenu(onPressed: (){}, title: "Date of Birth", value: "21 Aug, 2021"),

              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              Center(
                child: TextButton(onPressed: () => controller.deleteAccountWarningPopup(), child: const Text("Delete Account",style: TextStyle(color: Colors.red),)),
              )

            ],
          ),
        ),
      ),
    );

  }
}
