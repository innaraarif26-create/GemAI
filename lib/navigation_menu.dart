import 'package:flutter/material.dart';
import 'package:gemai/%20features/Main%20Screens/Home/Home.dart';
import 'package:gemai/core/constants/colors.dart';
import 'package:gemai/core/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget
{
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context)
  {
    final controller = Get.put(NavigationController());
    final darkMode = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
          ()=> NavigationBar(
            height: 70,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            backgroundColor: darkMode ? AppColors.black : AppColors.white,
            indicatorColor:  darkMode ? AppColors.white.withValues(alpha: 0.1) : AppColors.black.withValues(alpha: 0.1),
            destinations: const [
               NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
               NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
               NavigationDestination(icon: Icon(Iconsax.camera), label: "Capture"),
               NavigationDestination(icon: Icon(Iconsax.dollar_circle), label: "Valuation"),
               NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
            ]
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    Container(color: Colors.black),
    Container(color: Colors.red),
    Container(color: Colors.orange),
    Container(color: Colors.pink),
  ];
}
