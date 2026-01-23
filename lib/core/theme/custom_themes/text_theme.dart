import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
   headlineLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'TimesRomanFont'),
   headlineMedium: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,color: Colors.black87, fontFamily: 'TimesRomanFont'),
   headlineSmall: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600,color: Colors.black, fontFamily: 'TimesRomanFont'),

   titleLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
   titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
   titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),

   bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
   bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
   bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),

   labelLarge: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
   labelMedium:  TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'TimesRomanFont'),
    headlineMedium: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,color: Colors.white70, fontFamily: 'TimesRomanFont'),
    headlineSmall: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600,color: Colors.white, fontFamily: 'TimesRomanFont'),

    titleLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),

    bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),

    labelLarge: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium:  TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5)),

  );

}