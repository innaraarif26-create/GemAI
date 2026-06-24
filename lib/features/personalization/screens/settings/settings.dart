import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gemai/data/repositories/authentication/authentication_repository.dart';
import 'package:gemai/features/personalization/screens/address/widgets/address.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/layouts/list_tiles/settings_menu_tile.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../data/repositories/chat/chat_repository.dart';
import '../../../../widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../widgets/layouts/list_tiles/user_profile_tile.dart';
import '../../../MarketPlace/screens/chat/messages_screen.dart';
import '../../../MarketPlace/screens/wishlist/wishlist.dart';
import '../../../auth/screens/login/login_screen.dart';
import '../feedback/feedback_screen.dart';
import '../profile/profile.dart';

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
                    const SizedBox(height: AppSizes.spaceBtwItems,),

                    /// User Profile Card
                    AppUserProfileTile(onPressed: ()=> Get.to(ProfileScreen())),
                    const SizedBox(height: AppSizes.spaceBtwSections,),
                  ],
                )),
            /// Body
            Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Setting
                  AppSectionHeading(title: "Account",showActionButton: false,),
                  SizedBox(height: AppSizes.spaceBtwItems,),
                  AppSettingMenuTile(icon: Iconsax.edit, title: "Edit Profile", subTitle: "Keep your profile up to date", onTap: ()=> Get.to(ProfileScreen())),
                  AppSettingMenuTile(icon: Iconsax.safe_home, title: "My Address", subTitle: "Set Shopping delivery address", onTap: ()=> Get.to(UserAddressScreen())),
                  AppSettingMenuTile(icon: Iconsax.document_upload, title: "My Uploads", subTitle: "View and manage items you’ve uploaded", onTap: (){}),
                  AppSettingMenuTile(icon: Iconsax.heart, title: "My Favorites", subTitle: "Items you’ve saved for later", onTap: ()=> Get.to(FavouriteScreen())),
                  AppSettingMenuTile(icon: Iconsax.messages4, title: "Messages / Chats", subTitle: "View conversations with buyers and sellers",
                    onTap: () {
                      final user = FirebaseAuth.instance.currentUser;

                      if (user == null) {
                        Get.snackbar('Login required', 'Please login to view messages.');
                        return;
                      }

                      Get.to(() => MessagesScreen(
                        currentUserId: user.uid,
                        repo: ChatRepo(
                            FirebaseFirestore.instance,
                            FirebaseStorage.instance,
                        ),
                      ));
                    },
                  ),

                  /// Divider
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const Divider(thickness: 1),

                  /// Settings
                  SizedBox(height: AppSizes.spaceBtwItems),
                  AppSectionHeading(title: "Settings", showActionButton: false,),
                  SizedBox(height: AppSizes.spaceBtwItems,),
                  AppSettingMenuTile(icon: Iconsax.notification, title: "Notifications", subTitle: "Manage alerts for your account and listings", onTap: (){}),
                  AppSettingMenuTile(icon: Iconsax.message, title: "Feedback", subTitle: "Send us your suggestions", onTap: () => Get.to(() => const FeedbackScreen())),
                  AppSettingMenuTile(icon: Iconsax.document, title: "Terms of Use", subTitle: "Guidelines for using our services", onTap: (){}),
                  AppSettingMenuTile(icon: Iconsax.shield_tick, title: "Privacy Policy", subTitle: "Learn how we protect your personal information", onTap: (){}),
                  AppSettingMenuTile(icon: Iconsax.login, title: "Sign In / Sign Up", subTitle: "Sign in to manage and list your items", onTap: ()=> Get.to(LoginScreen())),

                  /// Logout Button
                  const SizedBox(height: AppSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: ()=> AuthenticationRepository.instance.logout(), child: const Text("Logout")),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
