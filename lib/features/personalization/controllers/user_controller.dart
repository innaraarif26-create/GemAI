import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/utils/popups/loaders.dart';
import '../../../data/repositories_authentication/user/user_repository.dart';
import '../models/user_model.dart';

class UserController extends GetxController
{
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

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
    }catch (e)
    {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? "");
        final username = UserModel.generateUsername(userCredentials.user!.displayName ?? "");

        // Map Data
        final user = UserModel(
          id: userCredentials.user!.uid,
          phoneNumber: userCredentials.user!.phoneNumber ?? "",
          firstName: nameParts.isNotEmpty ? nameParts[0] : "",
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
          username: username,
          email: userCredentials.user!.email ?? "",
          profilePicture: userCredentials.user!.photoURL ?? "",
        );

        // Save to Firestore
        await UserRepository.instance.saveUserRecord(user);
      }
    } catch (e) {
      AppLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
        'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
   }
  }
