import 'package:flutter/material.dart';
import 'package:gemai/core/utils/devices/device_utility.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/helpers/helper_functions.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({
    super.key, required this.tabs,

  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? AppColors.black : AppColors.white,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        tabs: tabs,
        isScrollable: true,
        indicatorColor: AppColors.buttonSecondary,
        labelColor: AppColors.buttonSecondary,
        unselectedLabelColor: AppColors.black,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtilities.getAppBarHeight());
}
