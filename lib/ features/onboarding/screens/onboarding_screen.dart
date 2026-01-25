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
              Padding(
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: Column(
                  children: [
                    Image(
                      width: AppHelperFunctions.screenWidth() * 0.8,
                      height: AppHelperFunctions.screenHeight() * 0.6,
                      image: AssetImage(AppImages.onBoardingImage1),
                    ),
                    Text(AppTexts.onBoardingTitle1,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
                    const SizedBox(height: AppSizes.spaceBtwItems,),
                    Text( AppTexts.onBoardingSubTitle1,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
