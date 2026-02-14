import 'package:flutter/material.dart';
import 'package:gemai/%20features/Main%20Screens/MarketPlace/store_categories.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import '../../../widgets/Favorite_Products/favorite_icon.dart';

class Store extends StatelessWidget
{
  const Store({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar: AppAppBar(
    title: Text("Store",style: Theme.of(context).textTheme.headlineMedium,),
      actions: [
        AppFavoriteCounterIcon(onPressed: () {}, iconColor: AppColors.black,),
      ]
     ),
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: AppHelperFunctions.isDarkMode(context) ? AppColors.black : AppColors.white,
                expandedHeight: 440,
                
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Search bar
                      const AppSearchContainer(text: 'Search in store',showBorder: true,showBackground: false,padding: EdgeInsets.zero,),
                      const SizedBox(height: AppSizes.defaultSpace,),

                      /// Categories
                      AppSectionHeading(title: 'Categories',),
                      const SizedBox(height: AppSizes.spaceBtwItems),
                      AppStorePopularCategories(),
                      const SizedBox(height: AppSizes.defaultSpace,),

                      /// Products
                      AppSectionHeading(title: 'Popular products',),
                      const SizedBox(height: AppSizes.spaceBtwItems),



                    ],
                  ),
                ),
              )
            ];
          },
          body: Container()),
    );
  }
}

