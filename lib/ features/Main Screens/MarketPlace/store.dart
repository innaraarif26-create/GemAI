import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/appbar/tabbar.dart';
import 'package:gemai/widgets/custom_shapes/containers/search_container.dart';
import 'package:gemai/widgets/texts/section_heading.dart';
import '../../../widgets/Favorite_Products/favorite_icon.dart';
import '../../../widgets/Products/product_cards/product_card_vertical.dart';
import '../../../widgets/layouts/grid_layout.dart';

class Store extends StatelessWidget
{
  const Store({super.key});

  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
      appBar: AppAppBar(
      title: Text("Store",style: Theme.of(context).textTheme.headlineMedium),
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
                  expandedHeight: 140,
                  
                  flexibleSpace: Padding(
                    padding: EdgeInsets.all(AppSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// Search bar
                        const AppSearchContainer(text: 'Search in store',showBorder: true,showBackground: false,padding: EdgeInsets.zero,),
                        const SizedBox(height: AppSizes.defaultSpace,),
                      ],
                    ),
                  ),
                  bottom: const AppTabBar(
                      tabs: [
                        Tab(child: Text("All"),),
                        Tab(child: Text("Precious"),),
                        Tab(child: Text("Semi Precious"),),
                        Tab(child: Text("Jewelry"),),
                        Tab(child: Text("Certified Gems"),),
                        Tab(child: Text("Raw Stones"),),

                      ]
                  )
                )
              ];
            }, 
          body: TabBarView(
           children:[
             ListView(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               children: [
                 Padding(
                 padding: EdgeInsets.all(AppSizes.spaceBtwItems),
                 child: Column(
                   children: [
                     const SizedBox(height: AppSizes.spaceBtwItems,),
                     AppSectionHeading(title: "All Products"),
                     const SizedBox(height: AppSizes.spaceBtwItems,),
                     AppGridLayout(itemCount: 4, itemBuilder: (_, index) => const AppProductCardVertical(),),
                     const SizedBox(height: AppSizes.spaceBtwItems,)
                   ],
                 ),
               ),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}


