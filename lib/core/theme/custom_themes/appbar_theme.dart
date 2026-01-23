import 'package:flutter/material.dart';

class AppbarTheme {

  AppbarTheme._();

  static const lightAppBarTheme = AppBarThemeData(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 20),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 20),
    titleTextStyle: TextStyle(fontSize: 22,fontFamily: 'TimesRomanFont', color: Colors.black,fontWeight: FontWeight.bold,)
  );

  static const darkAppBarTheme = AppBarThemeData(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, size: 20),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 20),
      titleTextStyle: TextStyle(fontSize: 22,fontFamily: 'TimesRomanFont', color: Colors.white,fontWeight: FontWeight.bold,)

  );
}