
import 'package:carman/home_page.dart';
import 'package:flutter/material.dart';
import 'package:carman/models/theme_data.dart';
class CarmanApp extends StatelessWidget {
  const CarmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      title:'Qualquer coisa',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home:  const HomePage(),
    );
  }
}