import 'package:flutter/material.dart';
import 'package:GemAI/widgets/Products/product_card/product_card_vertical.dart';
import 'package:GemAI/widgets/appbar/appbar.dart';
import 'package:GemAI/widgets/icons/circular_icon.dart';
import 'package:GemAI/widgets/layouts/grid_layout.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/sizes.dart';
import '../../../navigation_menu.dart';

class FavouriteScreen extends StatelessWidget
{
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text("Wishlist", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          AppCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(NavigationMenu()),)
        ],
      ),
     body: SingleChildScrollView(
       child: Padding(padding: EdgeInsets.all(AppSizes.defaultSpace),
         child: Column(
           children: [
             AppGridLayout(itemCount: 4, itemBuilder: (_,index)=>AppProductCardVertical()),
           ],
         ),
       ),
     ), 
    );
  }
}
