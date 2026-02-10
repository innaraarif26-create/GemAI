import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/sizes.dart';
import '../../core/utils/devices/device_utility.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key, this.title, required this.showBackArrow, this.leadingIcon, this.actions, required this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: AppBar(
        leading: showBackArrow
            ? IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios,color: Color(0xFFB48B54), size: 20))
            : IconButton(onPressed: leadingOnPressed,icon: Icon(leadingIcon,color: Color(0xFFB48B54), size: 20),))
      );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtilities.getAppBarHeight());
}
