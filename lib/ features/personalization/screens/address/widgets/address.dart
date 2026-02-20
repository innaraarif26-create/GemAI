import 'package:flutter/material.dart';
import 'package:gemai/%20features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:gemai/%20features/personalization/screens/address/widgets/single_address.dart';
import 'package:gemai/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget
{
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: ()=> Get.to(() => const AddNewAddressScreen()),
          backgroundColor: AppColors.accent,
          child: const Icon(Iconsax.add,color: AppColors.white,),
      ),
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text("Addresses",style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
              AppSingleAddress(selectedAddress: false),
              AppSingleAddress(selectedAddress: true),
          ],
        ),
      ),
    );
  }
}
