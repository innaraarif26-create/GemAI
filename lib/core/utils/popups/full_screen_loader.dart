import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/loaders/animation_loader.dart';
import '../../../widgets/loaders/circular_loader.dart';
import '../../constants/colors.dart';

class AppFullScreenLoader {

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppHelperFunctions.isDarkMode(Get.context!) ? AppColors.dark : AppColors.white,
          child: Center(
            child: AppAnimationLoaderWidget(text: text, animation: animation,),
          ),
        ),
      ),
    );
  }

  static void popUpCircular() {
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const AppCircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  static void stopLoading() {
    if (Get.overlayContext != null && Navigator.of(Get.overlayContext!).canPop()) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}