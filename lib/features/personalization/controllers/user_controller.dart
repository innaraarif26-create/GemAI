import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/network_manager.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/data/repositories_authentication/authentication/authentication_repository.dart';
import 'package:gemai/features/auth/screens/login/login_screen.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/re_authentication_user_login_form.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/utils/popups/loaders.dart';
import '../../../data/repositories_authentication/user/user_repository.dart';
import '../models/user_model.dart';

class UserController extends GetxController
{
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = UserRepository.instance;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit()
  {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    }
    catch (e)
    {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      if(user.value.id.isEmpty) {
        if (userCredentials != null) {
          // convert name to firstname and last name
          final nameParts = UserModel.nameParts(
              userCredentials.user!.displayName ?? "");
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? "");

          // Map Data
          final newUser = UserModel(
            id: userCredentials.user!.uid,
            phoneNumber: userCredentials.user!.phoneNumber ?? "",
            firstName: nameParts.isNotEmpty ? nameParts[0] : "",
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
            username: username,
            email: userCredentials.user!.email ?? "",
            profilePicture: userCredentials.user!.photoURL ?? "",
          );

          // Save to Firestore
          await UserRepository.instance.saveUserRecord(newUser);
        }
      }
    } catch (e) {
      AppLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
        'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
   }

   /// Delete Account Warning
   void deleteAccountWarningPopup()
   {
     Get.defaultDialog(
       contentPadding: const EdgeInsets.all(AppSizes.md),
       title: "Delete Account",
       middleText: "Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.",
       confirm: ElevatedButton(
           onPressed: () async => deleteUserAccount(),
           style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
           child:  const Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.lg), child: Text("Delete"),),
       ),
       cancel: OutlinedButton(
           onPressed: () => Navigator.of(Get.overlayContext!).pop(),
           child: Text("Cancel"),
       )
     );
   }

   /// Delete User Account
   void deleteUserAccount() async {
      try
          {
            AppFullScreenLoader.openLoadingDialog("Processing", AppImages.docerAnimation);

            /// First re-Authentication user
            final auth = AuthenticationRepository.instance;
            final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
            if(provider.isNotEmpty)
              {
                // Re-Verify Auth Email
                if(provider == "google.com")
                  {
                    await auth.signInWithGoogle();
                    await auth.deleteAccount();
                    AppFullScreenLoader.stopLoading();
                    Get.offAll(()=> const LoginScreen());
                  }
                else if(provider == "password")
                  {
                    AppFullScreenLoader.stopLoading();
                    Get.to(() => const ReAuthLoginForm());
                  }
              }
          }
      catch (e)
     {
       AppFullScreenLoader.stopLoading();
       AppLoaders.warningSnackBar(title: "Oh Snap", message: e.toString());
     }
   }

   /// Re-Authentication before deleting
   Future<void> reAuthenticateEmailAndPassword() async
   {
      try {
        AppFullScreenLoader.openLoadingDialog("Processing", AppImages.docerAnimation);

        // Check Internet
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected)
          {
            AppFullScreenLoader.stopLoading();
            return;
          }

        if(!reAuthFormKey.currentState!.validate())
          {
            AppFullScreenLoader.stopLoading();
            return;
          }
        await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(),verifyPassword.text.trim());
        await AuthenticationRepository.instance.deleteAccount();
        AppFullScreenLoader.stopLoading();
        Get.offAll(() => const LoginScreen());
      } catch (e) {
        AppFullScreenLoader.stopLoading();
        AppLoaders.warningSnackBar(title: "Oh Snap", message: e.toString());
      }
   }

   /// Upload Profile Image
   Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl = await userRepository.uploadImages(
            "users/Images/Profile/", image);

        // update User Image Record
        Map<String, dynamic> json = {"ProfilePicture": imageUrl};
        await userRepository.updateSingleField(json);

        user.update((val) {val!.profilePicture = imageUrl;});

        AppLoaders.successSnackBar(title: "Congratulations",
            message: "Your Profile Image has been updated");
      }
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Oh Snap",message: "Something went wrong: $e");
    } finally {
      imageUploading.value = false;
     }
   }
  }
