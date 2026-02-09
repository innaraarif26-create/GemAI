import 'package:flutter/material.dart';
import 'package:gemai/core/constants/colors.dart';
import '../../../widgets/custom_shapes/circular_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.accent,
              padding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  AppCircularContainer(backgroundColor: AppColors.textWhite.withValues(alpha: 0.1)),
                  AppCircularContainer(backgroundColor: AppColors.textWhite.withValues(alpha: 0.1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
