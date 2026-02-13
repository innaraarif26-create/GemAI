import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/custom_shapes/containers/search_container.dart';
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
                      SizedBox(height: AppSizes.spaceBtwItems,),
                      AppSearchContainer(text: 'Search in store',showBorder: true,showBackground: false,padding: EdgeInsets.zero,),
                      SizedBox(height: AppSizes.spaceBtwSections,)
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
