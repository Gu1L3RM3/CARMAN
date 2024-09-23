import 'package:flutter/material.dart';

final ThemeData lightMode=ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    // ignore: deprecated_member_use
    background: Colors.grey.shade500,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade300,
    tertiary: Colors.grey.shade200
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: true
  ),


);



final ThemeData darkMode=ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface:Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade600
  ),

  appBarTheme:const  AppBarTheme(
    centerTitle: true,
  ),
  
);