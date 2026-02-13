import 'package:flutter/material.dart';
import 'package:gemai/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:gemai/core/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/ features/Main Screens/Home/home_books_list.dart';
import '../../../widgets/texts/section_heading.dart';
import 'home_appbar.dart';
import 'home_articles_list.dart';
import 'home_popular_gems.dart';
import 'home_realfake_list.dart';

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
                        const AppHomePopularGems(),
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
                 AppSectionHeading(title: 'Real vs Fake',showActionButton: true, onPressed: (){},),
                 const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Real vs Fake Horizontal List
                  const AppRealFakeList(),
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


