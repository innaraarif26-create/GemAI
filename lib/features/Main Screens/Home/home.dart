import 'package:GemAI/features/Main%20Screens/Home/realfake_gems/all_real_fake_gems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
import '../../../widgets/texts/section_heading.dart';
import 'home_appbar.dart';
import 'Articles/home_articles_list.dart';
import 'home_books_list.dart';
import 'popular_gems/home_popular_gems_section.dart';
import 'realfake_gems/home_realfake_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ///HEADER
            AppPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  const AppHomeAppBar(),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Search Bar
                  AppSearchContainer(text: "Search for Gemstones"),
                  const SizedBox(height: AppSizes.defaultSpace),

                  /// Popular Gems Section
                  Padding( padding: const EdgeInsets.only( left: AppSizes.defaultSpace),
                    child: Column(
                      children: [
                        AppSectionHeading( title: 'Popular Gems',showActionButton: false, textColor: Colors.white,),
                        const SizedBox(height: AppSizes.spaceBtwItems),

                        /// Popular Gems List
                        const AppHomePopularGemsSection(),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// BODY
            Padding( padding:const EdgeInsets.only(left: AppSizes.defaultSpace),
              child: Column(
                children: [

                  /// Books Heading
                  AppSectionHeading(title: 'Books'),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Books Horizontal List
                 const AppHomeBooksList(),
                 const SizedBox(height: AppSizes.md),

                  /// Real vs Fake Heading
                 AppSectionHeading(title: 'Real vs Fake',showActionButton: true, onPressed: () => Get.to(() => const AllRealFakeGemsScreen()),),
                 const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Real vs Fake Horizontal List
                  const AppHomeRealFakeSection(),
                  const SizedBox(height: AppSizes.md),

                  /// Articles Heading
                  AppSectionHeading(title: 'Articles'),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Articles Horizontal List
                  const AppArticlesList(),
                  const SizedBox(height: AppSizes.md),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


