import 'package:carman/models/carro/caracter_car.dart';
import 'package:flutter/material.dart';

class FinancesCarPage extends StatelessWidget {
  final Carro carro ;
  
  const FinancesCarPage({super.key,required this.carro});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('página de finanças'),
    );
  }
}