import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/widgets/appbar/appbar.dart';
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
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort,color: Colors.grey,)),
                onChanged: (value){},
                items: ["Name", "Higher Price", "Lower Price","Newest","Popularity"].map((option)=> DropdownMenuItem(value: option,child: Text(option))).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
