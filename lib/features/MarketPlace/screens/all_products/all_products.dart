import 'package:gemai/core/constants/sizes.dart';
import 'package:gemai/features/MarketPlace/screens/product_details/widgets/product_card_vertical.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:gemai/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget
{
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppAppBar(title: Text("Popular Products"),showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// Dropdown
              DropdownButtonFormField(
                hint: Text("Sort by",style: Theme.of(context).textTheme.bodySmall),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort,color: Colors.grey,)),
                onChanged: (value){},
                items: ["Name", "Higher Price", "Lower Price","Newest","Popularity"].map((option)=> DropdownMenuItem(value: option,child: Text(option))).toList(),
              ),
              SizedBox(height: AppSizes.spaceBtwSections,),
              /// Products
              AppGridLayout(itemCount: 10, itemBuilder: (_, index)=> AppProductCardVertical()),
            ],
          ),
        ),
      ),
    );
  }
}
