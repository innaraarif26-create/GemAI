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
      minimumSize: Size(400, 40),
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
      textStyle: TextStyle(fontFamily: 'TimesRomanFont',fontSize: 18,color: Colors.white),
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
        minimumSize: Size(400, 40),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        textStyle: TextStyle(fontFamily: 'TimesRomanFont',fontSize: 18,color: Colors.white),
      )
  );


}