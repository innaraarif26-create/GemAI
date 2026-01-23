import 'package:flutter/material.dart';
import 'package:gemai/core/theme/custom_themes/text_field_theme.dart';
import 'package:gemai/core/theme/custom_themes/text_theme.dart';
import 'package:gemai/core/theme/custom_themes/elevated_button_theme.dart';
import 'package:gemai/core/theme/custom_themes/appbar_theme.dart';
import 'package:gemai/core/theme/custom_themes/bottom_sheet.dart';
import 'package:gemai/core/theme/custom_themes/checkbox_theme.dart';
import 'package:gemai/core/theme/custom_themes/chip_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'TimesRomanFont',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: AppbarTheme.lightAppBarTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: AppCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: AppChipTheme.lightAppChipTheme,
    inputDecorationTheme: AppTextFieldTheme.lightAppTextFieldTheme,
  );

  static ThemeData darkTheme =  ThemeData(
    useMaterial3: true,
    fontFamily: 'TimesRomanFont',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: AppCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: AppChipTheme.darkAppChipTheme,
    inputDecorationTheme: AppTextFieldTheme.darkAppTextFieldTheme,
  );

}