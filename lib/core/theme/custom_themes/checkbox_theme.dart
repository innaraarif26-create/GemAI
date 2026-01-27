import 'package:flutter/material.dart';

class AppCheckBoxTheme
{
  AppCheckBoxTheme._();

  static  CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states)
    {
      if(states.contains(WidgetState.selected))
        {
          return Colors.white;
        }
      else
        {
          return Color.fromARGB(255, 180, 139, 84);
        }
    }),
    fillColor: WidgetStateProperty.resolveWith((states)
      {
        if(states.contains(WidgetState.selected))
      {
        return Color.fromARGB(255, 180, 139, 84);
      }
        else
          {
            return Colors.transparent;
          }
      }),
    // side: const BorderSide(
    //   color: Color(0xFFB48B54),
    //   width: 2,
    // ),
  );

  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states)
    {
      if(states.contains(WidgetState.selected))
      {
        return Colors.white;
      }
      else
      {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states)
    {
      if(states.contains(WidgetState.selected))
      {
        return Colors.blue;
      }
      else
      {
        return Colors.transparent;
      }
    }),
    // side: const BorderSide(
    //   color: Color(0xFFB48B54), // border when unchecked
    //   width: 2,
    // ),
  );
}