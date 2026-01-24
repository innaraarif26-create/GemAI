import 'package:flutter/material.dart';
import 'package:gemai/core/theme/app_theme.dart';

void main() {
  runApp(const GemAi());
}

class GemAi extends StatelessWidget {
  const GemAi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}


