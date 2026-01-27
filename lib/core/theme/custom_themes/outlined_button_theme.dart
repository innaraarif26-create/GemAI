import 'package:flutter/material.dart';

class AppOutlinedButtonTheme
{
  AppOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style:  OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.grey,),
      textStyle: const TextStyle(fontFamily: 'TimesRomanFont',fontSize: 16, color: Colors.black),
      padding:  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    )
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style:  OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.grey),
        textStyle: const TextStyle(fontFamily: 'TimesRomanFont',fontSize: 16, color: Colors.black,),
        padding:  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      )
  );
}