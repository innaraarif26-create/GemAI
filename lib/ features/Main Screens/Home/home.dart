import 'package:flutter/material.dart';
import 'package:gemai/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gemai/core/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
import 'home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// Header Container
            AppPrimaryHeaderContainer(
              child: Column(
                children: [

                  /// Appbar
                  const AppHomeAppBar(),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  /// Search Bar
                  AppSearchContainer(text: "Search",icon: Iconsax.search_normal,),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

