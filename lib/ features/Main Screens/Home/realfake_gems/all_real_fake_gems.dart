import 'package:flutter/material.dart';
import 'package:GemAI/widgets/layouts/grid_layout.dart';
import 'package:get/get.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../../../../widgets/data/real_fake_gems_data.dart';
import '../../../../widgets/image_widget/rounded_image.dart';
import 'real_fake_detail_screen.dart';

class AllRealFakeGemsScreen extends StatelessWidget {
  const AllRealFakeGemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppAppBar(title: const Text("All Real vs Fake Gems"), showBackArrow: true,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: AppGridLayout(
            itemCount: realFakeGems.length,
            crossAxisCount: 2,
            mainAxisExtent: 220,
            itemBuilder: (_, index) {
              final gem = realFakeGems[index];
        
              return GestureDetector(
                onTap: () => Get.to(() => RealFakeDetailScreen(gem: gem["model"]),),
                child: Container(
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey.shade900 : const Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: dark ? Colors.black26 : Colors.grey.withValues(alpha: 0.25), blurRadius: 6, spreadRadius: 1,)
                    ],
                  ),
                  child: Column(
                    children: [
        
                      /// IMAGE
                      Expanded(
                        flex: 6,
                        child: Padding(padding: const EdgeInsets.all(AppSizes.sm),
                          child: AppRoundedImage(imageUrl: gem["image"], width: double.infinity, height: double.infinity, borderRadius: 12, fit: BoxFit.cover,),
                        ),
                      ),

                      ///  Title
                         Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs,vertical: AppSizes.md),
                            child: Column(
                              children: [
                                Text( "Real vs Fake", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                                Text(gem["title"],style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),)
                              ],
                            ),

                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}