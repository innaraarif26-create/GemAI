import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/sizes.dart';
import '../../core/utils/devices/device_utility.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.showBackArrow = false,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios, size: 20))
            : leadingIcon != null ? IconButton(onPressed: leadingOnPressed,icon: Icon(leadingIcon,size: 20)): null,
        title: title,
        actions: actions,

        ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtilities.getAppBarHeight());
}
