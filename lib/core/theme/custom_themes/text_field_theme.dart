import 'package:flutter/material.dart';

class AppTextFieldTheme
{
  AppTextFieldTheme._();

  static InputDecorationTheme lightAppTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor:  Color(0xFFB48B54),
    suffixIconColor:  Color(0xFFB48B54),
    labelStyle: const TextStyle().copyWith(fontFamily: 'TimesRomanFont', color: Colors.grey.shade700,fontSize: 14),
    hintStyle:  const TextStyle().copyWith(fontFamily: 'TimesRomanFont', color: Colors.grey.shade700,fontSize: 14),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal,fontFamily: 'TimesRomanFont'),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.grey.shade700,fontFamily: 'TimesRomanFont'),
    border: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(width: 1,color: Colors.grey),
    ),
    focusedBorder:UnderlineInputBorder( borderSide: BorderSide(width: 1,color: Colors.black12),),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),),
    errorBorder: const UnderlineInputBorder(borderSide:  BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.orange)),
  );

  static InputDecorationTheme darkAppTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor:  Color(0xFFB48B54),
    suffixIconColor:  Color(0xFFB48B54),
    labelStyle: const TextStyle().copyWith(fontFamily: 'TimesRomanFont', color: Colors.white,fontSize: 14),
    hintStyle:  const TextStyle().copyWith(fontFamily: 'TimesRomanFont', color: Colors.white,fontSize: 14),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal,fontFamily: 'TimesRomanFont'),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.white.withOpacity(0.8),fontFamily: 'TimesRomanFont'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1,color: Colors.grey),
    ),
    focusedBorder:UnderlineInputBorder( borderSide: BorderSide(width: 1,color: Colors.white),),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1,  color: Colors.grey),),
    errorBorder: const UnderlineInputBorder(borderSide:  BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.orange)),
  );
}