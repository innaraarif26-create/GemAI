import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController
{
  static OnboardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  // Update current index when page scroll
  void updatePageIndicator(index)
  {
    currentPageIndex = index;
  }

  // jump to the specific dot selected page.
  void dotNavigatorClick(index)
  {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // update current index and jump to next page
  void nextPage()
  {
    if(currentPageIndex.value == 2)
      {
       // Get.to(HomeScreen());
      }
    else
      {
        int page = currentPageIndex.value + 1;
        pageController.jumpToPage(page);
      }
  }
  // update current index and jump to the last page
  void skipPage()
  {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}