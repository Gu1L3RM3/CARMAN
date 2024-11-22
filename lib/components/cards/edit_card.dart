import 'package:carman/components/uso_geral/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class EditCard extends StatelessWidget {
  const EditCard({super.key});

  void delete(BuildContext context,String tipoAlerta,void Function() done)async{
    await showDialog(
      context: context,
      builder: (context)=>CustomAlertDialog(
        titulo: "Alerta",
        descricao: "Você realmente deseja excluir esse $tipoAlerta",
        doneText:'Excluir',
        closeText: 'Cancelar',
        onPressedDone: done,
        onPressedClose: (){Navigator.of(context).pop();},
        )
    );
  }
  Text texto({required String text,double fontsize=20})=>Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
       fontSize: fontsize,
       ),);
  Widget textWithOnTap({ void Function()? onTap,required String text}){
    return GestureDetector(
      onTap:onTap ,
      child: texto(text: text),
      );
  }
  Card card({double elevation=6.0,Widget? child}){
    return Card(
      elevation: elevation,
      child: child,
    );
  }
  GestureDetector container({required Widget child, void Function()? onTap,double radius=6.0,}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}