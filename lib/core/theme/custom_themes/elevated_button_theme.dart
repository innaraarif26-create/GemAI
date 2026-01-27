import 'package:flutter/material.dart';

class AppElevatedButtonTheme {

  AppElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData
  (
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 180, 139, 84),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      padding: EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
      textStyle: TextStyle(fontFamily: 'TimesRomanFont',fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
    )
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData
  (
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 180, 139, 84),
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        padding: EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
        textStyle: TextStyle(fontFamily: 'TimesRomanFont',fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
      )
  );
}