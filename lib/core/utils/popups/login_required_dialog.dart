import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/auth/screens/login/login_screen.dart';

Future<void> showLoginRequiredDialog({
  String title = "Login Required",
  String message = "Please login to continue.",
}) async {
  await Get.defaultDialog(
    title: title,
    middleText: message,
    textConfirm: "OK",
    textCancel: "Cancel",
    confirmTextColor: Colors.white,
    onConfirm: () {
      // close dialog
      if (Get.isDialogOpen ?? false) Get.back();

      // redirect to login
      Get.to(() => const LoginScreen());
    },
    onCancel: () {
      // just close
      if (Get.isDialogOpen ?? false) Get.back();
    },
  );
}