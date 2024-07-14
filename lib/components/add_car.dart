import 'package:flutter/material.dart';



class AddCar extends StatelessWidget {
  final Function() funcao;
  const AddCar({super.key,required  this.funcao});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(49, 44, 81, 1),
      onPressed: funcao,
      child: const Icon(Icons.add,color: Color.fromRGBO(241, 170, 155, 1))
      );
  }
}