import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/devices/device_utility.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gemai/core/constants/colors.dart';
import '../onboarding_controller.dart';

class OnboardingScreen  extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal scrollable Pages
          PageView(
            controller:  controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              onBoardingPage(image: AppImages.onBoardingImage1,title: AppTexts.onBoardingTitle1,subTitle: AppTexts.onBoardingSubTitle1,),
              onBoardingPage(image: AppImages.onBoardingImage2,title: AppTexts.onBoardingTitle2,subTitle: AppTexts.onBoardingSubTitle2,),
              onBoardingPage(image: AppImages.onBoardingImage3,title: AppTexts.onBoardingTitle3,subTitle: AppTexts.onBoardingSubTitle3,),
            ],
          ),
          // Skip Button
          onBoardingSkip(),
          // Dot Navigation SmoothPageIndicator
          onBoardingDotNavigation(),
          // Circular Button
          onBoardingNextButton()
        ],
      ),
    );
  }
}

class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
      right: AppSizes.defaultSpace,
      bottom: DeviceUtilities.getBottomNavigationBarHeight(),
      child: ElevatedButton( onPressed: ()
          {
            OnboardingController.instance.nextPage();
          },
          style: ElevatedButton.styleFrom(shape: CircleBorder(), backgroundColor: dark? AppColors.primary : Colors.black ),
          child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}

class onBoardingDotNavigation extends StatelessWidget {
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: DeviceUtilities.getBottomNavigationBarHeight(),
        left: AppSizes.defaultSpace,
        child: SmoothPageIndicator(controller: controller.pageController, count: 3,onDotClicked: controller.dotNavigatorClick,
        effect:  ExpandingDotsEffect(activeDotColor: dark? AppColors.light : AppColors.dark, dotHeight: 6,)
      ),
    );
  }
}

class onBoardingSkip extends StatelessWidget
{
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: DeviceUtilities.getAppBarHeight(),
        right: AppSizes.defaultSpace,
        child: TextButton(onPressed: ()
        {
          OnboardingController.instance.skipPage();
        },
        child: Text("Skip")));
  }
}

class onBoardingPage extends StatelessWidget {
  const onBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: AppHelperFunctions.screenWidth() * 0.7,
            height: AppHelperFunctions.screenHeight() * 0.5,
            image: AssetImage(image),
          ),
          Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
          const SizedBox(height: AppSizes.spaceBtwItems,),
          Text(subTitle,style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
