import 'package:carman/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final bool isHelper;
  final String? descricaoHelper;
  final Widget icon;
  final String? Function(String?)?  validate;
  final void Function(Object?)? onSaved;
  final List<String> lista;
  final String title;

  const CustomDropDown({
    super.key,
    this.isHelper=false,
    this.descricaoHelper,
    required this.validate,
    required this.icon,
    required this.onSaved,
    required this.lista,
    required this.title
  });


  List<DropdownMenuItem<String>>  criaLista(){
      List<DropdownMenuItem<String>> items=[];
      for (String obj in lista){
        items.add(DropdownMenuItem(value: obj,child: Text(obj),));

      }
      return items;
      
      
    }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(
        
        enableFeedback: true,  
        items:criaLista(),
        onChanged: (value){},
        autovalidateMode:AutovalidateMode.onUserInteraction ,
          decoration:  InputDecoration(
            helper:isHelper? GestureDetector(
              child: const Icon(Icons.help_center),
              onTap: (){
                showDialog(context: context, builder:(context)=>
                CustomAlertDialog(
                  apenasBotaoFechar: true,
                  onPressedClose: (){Navigator.of(context).pop();} ,
                  titulo: title, 
                  descricao: descricaoHelper??'',
                  
                  ));
              },):null ,
            border: const OutlineInputBorder(),
            icon: icon,
        ),
        onSaved: onSaved,
        validator:validate ,
        
        ),
    );
  }
}