import 'package:flutter/material.dart';
import 'package:gemai/core/constants/image_strings.dart';
import 'package:gemai/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:gemai/core/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/ features/Main Screens/Home/home_books_list.dart';
import '../../../widgets/texts/section_heading.dart';
import 'home_appbar.dart';
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
                  AppSectionHeading(title: 'Books', showActionButton: false,textColor: Colors.black,),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Books Horizontal List
                 const AppHomeBooksList(),
                 const SizedBox(height: AppSizes.md),

                  /// Real vs Fake Heading
                 AppSectionHeading(title: 'Real vs Fake', showActionButton: true,textColor: Colors.black,),
                 const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Real vs Fake Horizontal List
                  AppRealFakeList(),
                  const SizedBox(height: AppSizes.md),

                  /// Articles Heading
                  AppSectionHeading(title: 'Articles', showActionButton: false,textColor: Colors.black,),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  /// Articles Horizontal List
                  SizedBox(
                    height: AppSizes.articlesHeight,
                    child:  ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: (){},
                            child: Container(
                              width: 130,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [ BoxShadow(color: Colors.grey.withValues(alpha: 0.2))]
                              ),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top:Radius.circular(6) ),
                                    child: Image.asset(AppImages.),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
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
