import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/constants/text.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';

class OnboardingScreen  extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Horizontal scrollable Pages
          PageView(
            children: [
              onBoardingPage(image: AppImages.onBoardingImage1,title: AppTexts.onBoardingTitle1,subTitle: AppTexts.onBoardingSubTitle1,),
              onBoardingPage(image: AppImages.onBoardingImage2,title: AppTexts.onBoardingTitle2,subTitle: AppTexts.onBoardingSubTitle2,),
              onBoardingPage(image: AppImages.onBoardingImage3,title: AppTexts.onBoardingTitle3,subTitle: AppTexts.onBoardingSubTitle3,),
            ],
          )
        ],
      ),
    );
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
