import 'package:flutter/material.dart';

class AppColors
{
  AppColors._();

  // App Basic color
  static const  Color primary = Colors.blueAccent;
  static const  Color secondary = Color.fromARGB(255, 219, 37, 24);
  static const  Color accent=  Color(0xFF86520D);

  // Gradient Color
  static const Gradient linearGradient = LinearGradient(
    colors: [
      Color(0xFF86520D),
      Color(0xFFFFC78F)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Color
  static const  Color textPrimary = Color(0xFF333333);
  static const  Color textSecondary = Color(0xFF6C757D);
  static const  Color textWhite = Colors.white;

  // Background Colors
  static const  Color light = Color(0xFFF6F6F6);
  static const  Color dark = Color(0xFF272727);
  static const  Color primaryBackground = Color(0xFFF3F5FF);

  // BackGround Container color
  static const  Color lightContainer = Color(0xFFF6F6F6);
  static final  Color darkContainer =  AppColors.white.withValues(alpha: 0.1);
  static const  Color primaryContainer = Color.fromARGB(255, 248, 214, 217);

  // Button Color
  static const Color buttonPrimary =  Color(0xFF86520D);
  static const Color buttonSecondary = Color.fromARGB(255, 180, 139, 84);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border Color
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

 // Error and validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Natural shades
static const Color black = Colors.black;
static const Color darkerGrey = Color(0xFF4F4F4F);
static const Color darkGrey = Color(0x55939393);
static const Color grey = Color(0xFFE0E0E0);
static const Color softGrey = Color(0xFFF4F4F4);
static const Color lightGrey = Color(0xFFF9F9F9);
static const Color white = Color(0xFFFFFFFF);



}