import 'package:flutter/material.dart';
import 'package:GemAI/core/constants/sizes.dart';
import 'package:GemAI/widgets/appbar/appbar.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget
{
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: "Name",),),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Phone Number",),),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                Row(
                  children: [
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_34), labelText: "Street",),)),
                    const SizedBox(width: AppSizes.spaceBtwInputFields,),
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: "Postal Code",),)),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                Row(
                  children: [
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: "City",),)),
                    const SizedBox(width: AppSizes.spaceBtwInputFields,),
                    Expanded(child: TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: "State",),)),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: "Country",),),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.safe_home), labelText: "Complete Address",),),
                const SizedBox(height: AppSizes.spaceBtwInputFields,),
                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: Text("Save")),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
