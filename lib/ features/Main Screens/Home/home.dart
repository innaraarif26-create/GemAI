import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:gemai/core/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
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
                  AppSearchContainer(text: "Search"),
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
                  SizedBox(
                    height: AppSizes.bookHeight,
                    child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index)
                      {
                        return GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: AppSizes.bookWidth,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: AppSizes.bookHeight,
                                  width: AppSizes.bookWidth,
                                  margin:
                                  const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(6),
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.facebook), // change image
                                      fit: BoxFit.cover,
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

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
