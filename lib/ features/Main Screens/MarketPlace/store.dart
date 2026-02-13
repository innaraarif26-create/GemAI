import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:iconsax/iconsax.dart';

class Store extends StatelessWidget
{
  const Store({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar: AppAppBar(
    title: Text("Store"),
      actions: [
        Stack(
        children: [
          IconButton(onPressed: (){}, icon:  Icon(Iconsax.heart,color: AppColors.black,),),
          Positioned(
            right: 0,
            child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
              child: Center(
                child: Text("2",style: Theme.of(context).textTheme.labelLarge!.apply(color: AppColors.white)),
              ),
            ),
          ),
         ],
        ),
      ]
     )
    );
  }
}
