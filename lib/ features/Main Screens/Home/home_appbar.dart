import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text.dart';
import '../../../widgets/appbar/appbar.dart';
import '../../../widgets/custom_shapes/containers/primary_header_container.dart';

class AppHomeAppBar extends StatelessWidget {
  const AppHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppPrimaryHeaderContainer(
        child: Column(
          children: [
            AppAppBar(title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppTexts.homeAppBarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: AppColors.grey),),
                Text(AppTexts.homeAppBarSubTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColors.white),)
              ],
            ),),
          ],
        )
    );
  }
}
