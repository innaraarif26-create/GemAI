import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:GemAI/%20features/auth/login/login_screen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // Page Controller
  final PageController pageController = PageController();

  // Observable page index
  RxInt currentPageIndex = 0.obs;

  /// Update current index when page changes
  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  /// Jump to specific page when dot is clicked
  void dotNavigatorClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Move to next page or navigate to Login
  void nextPage() {
    if (currentPageIndex.value == 2)
    {
      Get.off(() => const LoginScreen());
    }
    else
    {
      currentPageIndex.value++;
      pageController.jumpToPage(currentPageIndex.value);
    }
  }

  /// Skip onboarding and go to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
