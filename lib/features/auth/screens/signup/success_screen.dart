import 'package:flutter/material.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:lottie/lottie.dart';


class SuccessScreen extends StatelessWidget
{
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title,subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSizes.appBarHeight,
            bottom: AppSizes.defaultSpace,
            left: AppSizes.defaultSpace,
            right: AppSizes.defaultSpace,
          ),
          child: Column(
            children: [
              /// Image
                Lottie.asset(image,width: MediaQuery.of(context).size.width * 0.6),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              /// Title and Sub title
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwItems,),
              Text(subTitle, style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: AppSizes.spaceBtwSections,),
              /// Buttons
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: onPressed, child: const Text('Continue')),)
            ],
          ),
        ),
      ),
    );
  }
}
