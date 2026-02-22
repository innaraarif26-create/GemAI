import 'package:flutter/material.dart';
import 'package:GemAI/%20features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:GemAI/widgets/appbar/appbar.dart';
import 'package:GemAI/widgets/texts/section_heading.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../widgets/image_widget/circular_image.dart';

class ProfileScreen extends StatelessWidget
{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
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
              
               AppProfileMenu(onPressed: (){}, title: "Name", value: "Coding with T"),
               AppProfileMenu(onPressed: (){}, title: "Username", value: "coding_with_t"),

              const SizedBox(height: AppSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              /// Heading OPersonal Info
              const AppSectionHeading(title: "Personal Information",showActionButton: false,),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              AppProfileMenu(onPressed: (){}, title: "User ID", value: "45689",icon: Iconsax.copy,),
              AppProfileMenu(onPressed: (){}, title: "Email", value: "coding_with_t"),
              AppProfileMenu(onPressed: (){}, title: "Phone Number", value: "+92-340-0189816"),
              AppProfileMenu(onPressed: (){}, title: "Gender", value: "Male"),
              AppProfileMenu(onPressed: (){}, title: "Date of Birth", value: "21 Aug, 2021"),

              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems,),

              Center(
                child: TextButton(onPressed: (){}, child: const Text("Delete Account",style: TextStyle(color: Colors.red),)),
              )

            ],
          ),
        ),
      ),
    );

  }
}
