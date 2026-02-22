import 'package:flutter/material.dart';
import 'package:GemAI/core/utils/helpers/helper_functions.dart';
import 'package:GemAI/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class AppSingleAddress extends StatelessWidget
{
  const AppSingleAddress({
    super.key,
    required this.selectedAddress
  });

  final bool selectedAddress;

  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);
    return AppRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: EdgeInsets.all(AppSizes.md),
      backgroundColor: selectedAddress ? AppColors.accent.withValues(alpha: 0.5) : Colors.transparent,
      borderColor: selectedAddress ? Colors.transparent : dark ? AppColors.darkerGrey : AppColors.grey,
      margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
            color: selectedAddress ? dark ? AppColors.light : AppColors.dark.withValues(alpha: 0.6) : null
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tufail Haider",
              maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.sm / 2,),
              const Text("+92340 0189816", maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: AppSizes.sm / 2,),
              const Text("Baig Market Danyore, Gilgit, Gilgit Baltistan",softWrap: true,)
            ],
          )
        ],
      ),
    );
  }
}
