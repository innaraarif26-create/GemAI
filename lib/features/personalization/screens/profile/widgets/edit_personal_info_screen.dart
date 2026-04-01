import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/network_manager.dart';
import 'package:gemai/core/utils/popups/full_screen_loader.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:gemai/core/utils/validators/validation.dart';
import 'package:gemai/data/repositories/authentication/authentication_repository.dart';
import 'package:gemai/data/repositories/user/user_repository.dart';
import 'package:gemai/features/personalization/controllers/user_controller.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/image_strings.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  final String fieldType; // 'username', 'email', 'phone', 'gender', 'dob', 'userid'

  const EditPersonalInfoScreen({
    super.key,
    required this.fieldType,
  });

  @override
  State<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late String selectedGender;
  bool isLoading = false;

  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  final authRepository = AuthenticationRepository.instance;
  final formKey = GlobalKey<FormState>();

  final List<String> genderOptions = ["Male", "Female", "Other"];

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: userController.user.value.username);
    emailController = TextEditingController(text: userController.user.value.email);
    phoneController = TextEditingController(text: userController.user.value.phoneNumber);
    dobController = TextEditingController(text: userController.user.value.dateOfBirth);
    selectedGender = userController.user.value.gender.isEmpty
        ? "Male"
        : userController.user.value.gender;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  String _getMonthName(int month) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[month - 1];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day} ${_getMonthName(picked.month)}, ${picked.year}";
      });
    }
  }

  Future<void> updateUserInfo() async {
    try {
      setState(() => isLoading = true);
      AppFullScreenLoader.openLoadingDialog("Updating information...", AppImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        AppLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your internet connection.",
        );
        setState(() => isLoading = false);
        return;
      }

      if (!formKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        setState(() => isLoading = false);
        return;
      }

      Map<String, dynamic> updateData = {};
      bool isEmailUpdate = false;

      // Handle different field types
      switch (widget.fieldType) {
        case 'username':
          if (usernameController.text.trim() == userController.user.value.username) {
            AppFullScreenLoader.stopLoading();
            AppLoaders.warningSnackBar(
              title: "No Changes",
              message: "Username is the same as before.",
            );
            setState(() => isLoading = false);
            return;
          }
          updateData = {"Username": usernameController.text.trim()};
          userController.user.value.username = usernameController.text.trim();
          break;

        case 'email':
          if (emailController.text.trim() == userController.user.value.email) {
            AppFullScreenLoader.stopLoading();
            AppLoaders.warningSnackBar(
              title: "No Changes",
              message: "Email is the same as before.",
            );
            setState(() => isLoading = false);
            return;
          }

          final newEmail = emailController.text.trim();

          // Step 1: Update Firebase Auth Email with verification
          await authRepository.updateUserEmail(newEmail);

          // Step 2: Immediately update Firestore email as well
          updateData = {"Email": newEmail};
          await userRepository.updateSingleField(updateData);

          // Step 3: Update local controller
          userController.user.value.email = newEmail;
          userController.user.refresh();

          isEmailUpdate = true;
          break;

        case 'phone':
          if (phoneController.text.trim() == userController.user.value.phoneNumber) {
            AppFullScreenLoader.stopLoading();
            AppLoaders.warningSnackBar(
              title: "No Changes",
              message: "Phone number is the same as before.",
            );
            setState(() => isLoading = false);
            return;
          }
          updateData = {"PhoneNumber": phoneController.text.trim()};
          userController.user.value.phoneNumber = phoneController.text.trim();
          break;

        case 'gender':
          if (selectedGender == userController.user.value.gender) {
            AppFullScreenLoader.stopLoading();
            AppLoaders.warningSnackBar(
              title: "No Changes",
              message: "Gender is the same as before.",
            );
            setState(() => isLoading = false);
            return;
          }
          updateData = {"Gender": selectedGender};
          userController.user.value.gender = selectedGender;
          break;

        case 'dob':
          if (dobController.text.trim() == userController.user.value.dateOfBirth) {
            AppFullScreenLoader.stopLoading();
            AppLoaders.warningSnackBar(
              title: "No Changes",
              message: "Date of birth is the same as before.",
            );
            setState(() => isLoading = false);
            return;
          }
          updateData = {"DateOfBirth": dobController.text.trim()};
          userController.user.value.dateOfBirth = dobController.text.trim();
          break;

        case 'userid':
          AppFullScreenLoader.stopLoading();
          AppLoaders.warningSnackBar(
            title: "Cannot Edit",
            message: "User ID cannot be changed.",
          );
          setState(() => isLoading = false);
          return;
      }

      // Update Firestore for non-email fields
      if (widget.fieldType != 'email') {
        await userRepository.updateSingleField(updateData);
        userController.user.refresh();
      }

      AppFullScreenLoader.stopLoading();

      // Show success message
      if (isEmailUpdate) {
        AppLoaders.successSnackBar(
          title: "Verification Email Sent",
          message: "Verification link has been sent to your new email address.",
        );
      } else {
        AppLoaders.successSnackBar(
          title: "Success",
          message: "Your information has been updated successfully.",
        );
      }

      // Update UI - refresh the screen with new data
      setState(() {
        // Update text controllers to show new values
        usernameController.text = userController.user.value.username;
        emailController.text = userController.user.value.email;
        phoneController.text = userController.user.value.phoneNumber;
        dobController.text = userController.user.value.dateOfBirth;
        selectedGender = userController.user.value.gender.isEmpty ? "Male" : userController.user.value.gender;
      });

      setState(() => isLoading = false);

    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      setState(() => isLoading = false);
    }
  }

  void _copyUserId() {
    Clipboard.setData(
      ClipboardData(text: userController.user.value.id),
    );
    AppLoaders.successSnackBar(
      title: "Copied",
      message: "User ID copied to clipboard",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(_getAppBarTitle()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  _getScreenDescription(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Render different widgets based on fieldType
                _buildEditWidget(context),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Save Button
                if (widget.fieldType != 'userid')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : updateUserInfo,
                      child: isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text("Save Changes"),
                    ),
                  ),

                /// Back Button (Optional)
                if (widget.fieldType != 'userid')
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Back to Profile"),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (widget.fieldType) {
      case 'username':
        return "Update Your Username";
      case 'email':
        return "Update Your Email";
      case 'phone':
        return "Update Your Phone Number";
      case 'gender':
        return "Select Your Gender";
      case 'dob':
        return "Update Your Date of Birth";
      case 'userid':
        return "Your Unique User ID";
      default:
        return "Update Your Information";
    }
  }

  String _getScreenDescription() {
    switch (widget.fieldType) {
      case 'username':
        return "Enter a new username. Username must be 3-20 characters and can contain letters, numbers, hyphens, and underscores.";
      case 'email':
        return "Enter your new email address. A verification link will be sent to this email. You must verify it before the change takes effect.";
      case 'phone':
        return "Enter your new phone number. We'll verify it with an SMS.";
      case 'gender':
        return "Select your gender to help us personalize your experience.";
      case 'dob':
        return "Select your date of birth. This information helps us personalize your experience.";
      case 'userid':
        return "This ID is unique to your account and cannot be changed.";
      default:
        return "";
    }
  }

  Widget _buildEditWidget(BuildContext context) {
    switch (widget.fieldType) {
      case 'username':
        return TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.user),
            labelText: "Username",
            hintText: "john_doe",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            helperText: "3-20 characters. Letters, numbers, hyphens, underscores only.",
          ),
          validator: AppValidator.validateUsername,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        );

      case 'email':
        return TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.direct_right),
            labelText: "Email Address",
            hintText: "example@gmail.com",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: AppValidator.validateEmail,
          keyboardType: TextInputType.emailAddress,
        );

      case 'phone':
        return TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.call),
            labelText: "Phone Number",
            hintText: "+92 (300) 000-0000",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a phone number";
            }
            if (value.length < 10) {
              return "Please enter a valid phone number";
            }
            return null;
          },
          keyboardType: TextInputType.phone,
        );

      case 'gender':
        return Column(
          children: genderOptions.map((gender) {
            return RadioListTile<String>(
              title: Text(gender),
              value: gender,
              groupValue: selectedGender,
              activeColor: AppColors.buttonSecondary,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    selectedGender = value;
                  }
                });
              },
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        );

      case 'dob':
        return TextFormField(
          controller: dobController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Iconsax.calendar),
            labelText: "Date of Birth",
            hintText: "DD MMM, YYYY",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
              icon: const Icon(Iconsax.calendar_1),
              onPressed: () => _selectDate(context),
            ),
          ),
          readOnly: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select date of birth";
            }
            return null;
          },
        );

      case 'userid':
        return Container(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade50,
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                      () => Text(
                    userController.user.value.id,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              IconButton(
                icon: const Icon(Iconsax.copy),
                onPressed: _copyUserId,
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}