
import 'package:carman/home_page.dart';
import 'package:flutter/material.dart';


class CarmanApp extends StatelessWidget {
  const CarmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
      title:'Qualquer coisa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home:  const HomePage(),
    );
  }
}