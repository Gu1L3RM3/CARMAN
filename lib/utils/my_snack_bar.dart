import 'package:flutter/material.dart';

class MySnackbar{
  static showSnackBar({
    required BuildContext context,
    required String texto,
  }){
    SnackBar snackBar=SnackBar(
      content: Text(texto,style: const TextStyle(color: Colors.white),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      duration: Durations.short4,
      backgroundColor: Colors.green,
      
      );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}