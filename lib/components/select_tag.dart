
import 'package:carman/components/custom_drop_down.dart';
import 'package:carman/main.dart';
import 'package:carman/models/config_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SelectTag extends CustomDropDown {
  
  

  SelectTag({

    super.key,
    super.descricaoHelper,
    super.isHelper,
    required super.validate,
    required super.icon, 
    required super.onSaved, 
    super.lista=const [], 
    required super.title,

  });
  final ConfigService configService=Provider.of<ConfigService>(navigatorKey.currentContext!,listen:true);
  @override
  List<DropdownMenuItem<String>>  criaLista(){
      List<DropdownMenuItem<String>> items=[];
      for (List tagList in configService.tags){
        items.add(DropdownMenuItem(value: tagList[0],child: Text(tagList[0]),));

      }
      return items;
      
      
    }
    
  
}