
import 'package:flutter/cupertino.dart';
import 'package:gemai/core/utils/helpers/network_manager.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/data/repositories_authentication/user/user_repository.dart';
import 'package:gemai/features/personalization/controllers/user_controller.dart';
import 'package:gemai/features/personalization/screens/profile/widgets/profile.dart';
import 'package:get/get.dart';

import '../../../core/constants/image_strings.dart';

class UpdateNameController extends GetxController
{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when home screen appears
 @override
  void onInit()
 {
   initializeNames();
  super.onInit();
 }

 /// Fetch user record
 Future<void> initializeNames() async
 {
   firstName.text = userController.user.value.firstName;
   lastName.text = userController.user.value.lastName;
 }

 Future<void> updateUserName() async {
   try {
     // Start Loading
     AppFullScreenLoader.openLoadingDialog("We are updating your information...", AppImages.docerAnimation);

     // Check Internet Connection
     final isConnected = await NetworkManager.instance.isConnected();
     if(!isConnected)
       {
        AppFullScreenLoader.stopLoading();
        return;
       }
     // Form validation
     if(!updateUserNameFormKey.currentState!.validate())
       {
         AppFullScreenLoader.stopLoading();
         return;
       }

     // Update users first and last name in the firestore firebase
     Map<String, dynamic> name = {"FirstName":firstName.text.trim(), "LastName": lastName.text.trim()};
     await userRepository.updateSingleField(name);

     // update the Rx User value
     userController.user.value.firstName = firstName.text.trim();
     userController.user.value.lastName = lastName.text.trim();

     // Remove Loader
     AppFullScreenLoader.stopLoading();

     // show Success Message
     AppLoaders.successSnackBar(title: "Congratulations",message: "Your Name has been update.");

     // Move to previous Screen.
     Get.off(() => const ProfileScreen());
   } catch (e)
   {
     AppFullScreenLoader.stopLoading();
     AppLoaders.errorSnackBar(title: "Oh Snap",message: e.toString());
   }
 }

}