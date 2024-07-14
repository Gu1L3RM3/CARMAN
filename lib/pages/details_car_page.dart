import 'package:carman/models/caracter_car.dart';
import 'package:flutter/material.dart';

class DetailsCarPage extends StatelessWidget {
  const DetailsCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Carro carro=ModalRoute.of(context)?.settings.arguments as Carro;
    return  Scaffold(
      appBar: AppBar(
        title: Text(carro.apelido),
      ),
     
    );
  }
}