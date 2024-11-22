import 'dart:io';

import 'package:carman/components/cards/edit_card.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:flutter/material.dart';

class CarCard extends EditCard {
  final void Function() onTap;
  final Carro carro;
  const CarCard({
    super.key,
    required this.onTap,
    required this.carro


  });

  @override
  Widget build(BuildContext context) {
    return card(
      child:container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.file(File(carro.imageCar)),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      texto(text: carro.modelo),
                      texto(text: carro.marca),
                      texto(text: carro.ano.toString())],
                  )
                  
              
                ],
              ),
            )
          ],
        ),
        ) ,
      );

      
  }
}