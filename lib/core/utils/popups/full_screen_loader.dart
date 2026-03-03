import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../widgets/loaders/animation_loader.dart';
import '../../constants/colors.dart';

class AppFullScreenLoader {
  static void openLoadingDialog(String text, String animation)
  {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
            child: Container(
              color: AppHelperFunctions.isDarkMode(Get.context!) ? AppColors.dark : AppColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250,),
                  AppAnimationLoaderWidget(text: text, animation: animation)
                ],
              ),
            ),
        ),
    );
  }
  static stopLoading()
  {
    Navigator.of(Get.overlayContext!).pop();
  }
}