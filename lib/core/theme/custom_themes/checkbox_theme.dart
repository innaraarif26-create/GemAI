import 'package:flutter/material.dart';

class AppCheckBoxTheme
{
  AppCheckBoxTheme._();

  static  CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states)
    {
      if(states.contains(MaterialState.selected))
        {
          return Colors.white;
        }
      else
        {
          return Color.fromARGB(255, 180, 139, 84);
        }
    }),
    fillColor: MaterialStateProperty.resolveWith((states)
      {
        if(states.contains(MaterialState.selected))
      {
        return Color.fromARGB(255, 180, 139, 84);
      }
        else
          {
            return Colors.transparent;
          }
      }),
  );



  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states)
    {
      if(states.contains(MaterialState.selected))
      {
        return Colors.white;
      }
      else
      {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states)
    {
      if(states.contains(MaterialState.selected))
      {
        return Colors.blue;
      }
      else
      {
        return Colors.transparent;
      }
    }),
  );
}