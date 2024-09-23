import 'package:carman/components/uso_geral/custom_alert_dialog.dart';
import 'package:carman/models/config_service.dart';
import 'package:flutter/material.dart';

class TagsEdit extends StatelessWidget {
  final String tagName;
  final ConfigService provider;
  final int id;
  const TagsEdit({super.key,required this.tagName,required this.provider,required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        return await showDialog(
          context: context,
          builder: (context)=>provider.tagCanRemove(tagName)? CustomAlertDialog(
          titulo: "Alerta", 
          descricao: "Você realmente deseja excluir este serviço?",
          closeText: "Cancelar",
          doneText: "Excluir",
          onPressedClose: ()=>Navigator.of(context).pop(),
          onPressedDone: (){
              provider.removeTag(id);
              Navigator.of(context).pop();
              },
          )
          :CustomAlertDialog(
              titulo: "Aviso", 
              descricao: "Você não pode excluir este serviço\nEste serviço é pré-definido pelo aplicativo",
              apenasBotaoFechar: true,
             onPressedClose: ()=>Navigator.of(context).pop(),
            )
                                );
                            
                          },
      child: Text(tagName ,style: const TextStyle(fontSize: 20.0),));
  }
}