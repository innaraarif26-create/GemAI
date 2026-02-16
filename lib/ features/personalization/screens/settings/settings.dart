import 'package:flutter/material.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/layouts/list_tiles/settings_menu_tile.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../widgets/layouts/list_tiles/user_profile_tile.dart';

class SettingScreen extends StatelessWidget
{
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            AppPrimaryHeaderContainer(
                child: Column(
                  children: [
                    AppAppBar(title: Text("Account", style: Theme.of(context).textTheme.headlineMedium!.apply(color: AppColors.white))),
                    const SizedBox(height: AppSizes.spaceBtwSections,),
                    
                    /// User Profile Card
                    AppUserProfileTile(),
                    const SizedBox(height: AppSizes.spaceBtwSections,),
                  ],
            )),
            /// Body
            Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Setting
                  AppSectionHeading(title: "Account Setting",showActionButton: false,),
                  SizedBox(height: AppSizes.spaceBtwItems,),

                    AppSectionMenuTitle(icon: Iconsax.safe_home, title: "My Address", subTitle: "Set SHopping delivery address", onTap: (){}),
                    AppSectionMenuTitle(icon: Iconsax.edit, title: "Edit Profile", subTitle: "Keep your profile up to date", onTap: (){}),
                    AppSectionMenuTitle(icon: Iconsax.message, title: "Feedback", subTitle: "Send us your suggestions", onTap: (){}),
                    AppSectionMenuTitle(icon: Iconsax.login, title: "Sign In / Sign Up", subTitle: "Sign in to manage and list your items", onTap: (){}),
                    AppSectionMenuTitle(icon: Iconsax.heart, title: "My Favorite", subTitle: "Items you’ve saved for later", onTap: (){}),
                    AppSectionMenuTitle(icon: Iconsax.heart, title: "Notifications", subTitle: "Manage alerts for your account and listings", onTap: (){}),
                    AppSectionMenuTitle(icon: Icons.description, title: "Terms of Use", subTitle: "Guidelines for using our services", onTap: (){}),
                    AppSectionMenuTitle(icon: Icons.privacy_tip, title: "Privacy Policy", subTitle: "Learn how we protect your personal information", onTap: (){}),

                  /// Logout Button
                  const SizedBox(height: AppSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){}, child: const Text("Logout")),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections * 2.5)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
