import 'package:flutter/material.dart';
import 'package:gemai/widgets/Products/product_cards/product_card_vertical.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/icons/circular_icon.dart';
import 'package:gemai/widgets/layouts/grid_layout.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget
{
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppAppBar(
        title: Text("Wishlist", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          AppCircularIcon(icon: Iconsax.add, onPressed: () => Get.back(),)
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
