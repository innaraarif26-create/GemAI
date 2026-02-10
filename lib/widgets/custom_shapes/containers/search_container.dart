
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/utils/devices/device_utility.dart';
import '../../../core/utils/helpers/helper_functions.dart';

class AppSearchContainer extends StatelessWidget {
  const AppSearchContainer({
    super.key, required this.text, this.icon, this.showBackground = true, this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {

    final dark = AppHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: AppSizes.defaultSpace,),
      child: Container(
        width: DeviceUtilities.getScreenWidth(context),
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color:showBackground ? dark ? AppColors.dark : AppColors.light : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg,),
          border: showBorder ? Border.all(color: AppColors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(icon ,color: AppColors.darkerGrey,size: 20,),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(text,  style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),
      ),
    );
  }
}