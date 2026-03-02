import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/colors.dart';

class AppLoaders {
  /// Success Snackbar
  static void successSnackBar({
    required String title,
    String message = "",
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: AppColors.accent,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.tick_circle, color: AppColors.white),
    );
  }

  /// Warning Snackbar
  static void warningSnackBar({
    required String title,
    String message = "",
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.warning_2, color: AppColors.white),
    );
  }

  /// Error Snackbar (Recommended for FYP)
  static void errorSnackBar({
    required String title,
    String message = "",
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.close_circle, color: AppColors.white),
    );
  }
}