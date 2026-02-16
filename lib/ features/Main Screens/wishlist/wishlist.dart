import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/icons/circular_icon.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../MarketPlace/store.dart';

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
          AppCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const Store()),)
        ],
      ),
    );
  }
}
