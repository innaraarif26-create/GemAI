import 'package:flutter/material.dart';
import 'package:gemai/core/theme/app_theme.dart';
import 'package:gemai/ features/onboarding/screens/onboarding_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const GemAi());
}

class GemAi extends StatelessWidget {
  const GemAi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: OnboardingScreen(),
    );
  }
}


