import 'package:flutter/material.dart';

class AppColors
{
  AppColors._();

  // App Basic color
  static const  Color primary = Color(0xFF4b68ff);
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
  static const  Color textPrimary = Colors.black;
  static const  Color textSecondary = Color(0xFFB48B54);
  static const  Color textWhite = Colors.white;

  // Background Colors
  static const  Color light = Color(0xFFF7ECE1);
  static const  Color dark = Color(0xFF272727);
  static const  Color primaryBackground = Color.fromARGB(255, 245, 236, 227);

  // BackGround Container color
  static const  Color lightContainer = Colors.white;
  static const  Color darkContainer =  Color.fromARGB(255, 248, 230, 204);
  static const  Color primaryContainer = Color.fromARGB(255, 248, 214, 217);

  // Button Color
  static const Color buttonPrimary =  Color(0xFF86520D);
  static const Color buttonSecondary = Color.fromARGB(255, 180, 139, 84);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border Color
  static const Color borderPrimary = Colors.grey;
  static const Color borderSecondary = Color.fromARGB(255, 180, 139, 84);

 // Error and validation Colors
  static const Color error = Colors.red;
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
static const Color white = Colors.white;



}