import 'package:flutter/material.dart';
ThemeData theme=ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(49, 44, 81, 1),
    titleTextStyle:  TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Color.fromRGBO(240, 195, 142, 1)
        ),
    centerTitle: true,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color.fromRGBO(240, 195, 142, 1),
    unselectedItemColor:Color.fromRGBO(72, 66, 109, 1) ,
    backgroundColor:Color.fromRGBO(49, 44, 81, 1) ,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    

  ),
  
  
  colorScheme: const ColorScheme.light(
    // ignore: deprecated_member_use
    background: Color.fromRGBO(72, 66, 109, 1),),  

);