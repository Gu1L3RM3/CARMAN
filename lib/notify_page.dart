import 'package:flutter/material.dart';
const cor1=Color.fromRGBO(241, 170, 155, 1);
const cor2=Color.fromRGBO(240, 195, 142, 1);
const cor3=Color.fromRGBO(72, 66, 109, 1);
const cor4=Color.fromRGBO(49, 44, 81, 1);
const cor5=Color.fromRGBO(40, 36, 67, 1);

class NotifyPage extends StatelessWidget {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: cor2
        ),
        centerTitle: true,
        backgroundColor: cor4,
        
         ),
      backgroundColor: cor3,
      
    );
  }
}