import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String descricao;
  final String titulo;
  final String doneText;
  final String closeText;
  final Widget? widget;
  final bool apenasBotaoFechar;
  final void Function()? onPressedDone;
  final void Function()? onPressedClose;



  const CustomAlertDialog({
    super.key,
    required this.titulo,
    required this.descricao,
    this.doneText ='Concluir',
    this.closeText='Fechar',
    this.onPressedDone,
    this.onPressedClose,
    this.apenasBotaoFechar=false,
    this.widget


  });
  

  @override
  Widget build(BuildContext context) {
    final listaActions= <Widget>[
        TextButton(
          onPressed: onPressedDone,
          child:Text(doneText,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:20.0 )), ),
        TextButton(
          onPressed: onPressedClose,
          child:Text(closeText,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:20.0 )), )
      ];
    if (apenasBotaoFechar){
    listaActions.removeAt(0);
    }
    
    return AlertDialog(
      alignment: Alignment.center,
      
      title: Text(titulo),
      content:widget ?? Text(descricao,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.justify,),
      contentPadding: const EdgeInsets.all(8.0),
      actionsAlignment:apenasBotaoFechar ?  MainAxisAlignment.end:MainAxisAlignment.spaceBetween,
      actions: listaActions,
      

    );
  }
}