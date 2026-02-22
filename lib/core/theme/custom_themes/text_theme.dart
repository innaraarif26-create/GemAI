import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(

   headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'TimesRomanFont'),
   headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600,color: Colors.black87, fontFamily: 'TimesRomanFont'),
   headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600,color: Colors.black, fontFamily: 'TimesRomanFont'),

   titleLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'TimesRomanFont'),
   titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'TimesRomanFont'),
   titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black, fontFamily: 'TimesRomanFont'),

   bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'TimesRomanFont'),
   bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'TimesRomanFont'),
   bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withValues(alpha: 0.5), fontFamily: 'TimesRomanFont'),

   labelLarge: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'TimesRomanFont'),
   labelMedium:  TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black.withValues(alpha: 0.5), fontFamily: 'TimesRomanFont'),

  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'TimesRomanFont'),
    headlineMedium: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,color: Colors.white, fontFamily: 'TimesRomanFont'),
    headlineSmall: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white, fontFamily: 'TimesRomanFont'),

    titleLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'TimesRomanFont'),
    titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'TimesRomanFont'),
    titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'TimesRomanFont'),

    bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'TimesRomanFont'),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'TimesRomanFont'),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withValues(alpha: 0.5), fontFamily: 'TimesRomanFont'),

    labelLarge: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'TimesRomanFont'),
    labelMedium:  TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white.withValues(alpha: 0.5), fontFamily: 'TimesRomanFont'),

  );

}