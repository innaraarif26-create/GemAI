import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:gemai/core/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/ features/Main Screens/Home/home_books_list.dart';
import '../../../widgets/texts/section_heading.dart';
import 'home_appbar.dart';
import 'home_popular_gems.dart';

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
                  AppSectionHeading(title: 'Books', showActionButton: false,textColor: Colors.black,),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Books Horizontal List
                 const AppHomeBooksList(),
                 const SizedBox(height: AppSizes.md),

                  /// Real vs Fake Heading
                 AppSectionHeading(title: 'Real vs Fake', showActionButton: true,textColor: Colors.black,),
                 const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Real vs Fake Horizontal List
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,  
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(AppSizes.sm),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 85,
                                    width: 90,
                                    child: Image.asset(AppImages),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

