import 'package:flutter/material.dart';



class FloatingAddObject extends StatelessWidget {
  final Function()? funcao;
  final Widget? child;
  const FloatingAddObject({
  super.key,
  this.child,
  required  this.funcao
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      onPressed: funcao??(){},
      child: child??const Icon(Icons.add)
      );
  }
}