import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/utils/devices/device_utility.dart';
import 'home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              /// Appbar
              AppHomeAppBar(),
              const SizedBox(height: AppSizes.spaceBtwSections ,),
              /// SearchBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
                child: Container(
                  width:  DeviceUtilities.getScreenWidth(context),
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.search_normal, color: AppColors.grey,),
                      const SizedBox(width: AppSizes.spaceBtwItems,),
                      Text("Search", style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                ),
              )
              /// Categories
            ],
        ),
      ),
    );
  }
}

