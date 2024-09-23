import 'package:carman/components/uso_geral/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputText extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final String? descricaoHelper;
  final bool isHelper;
  final bool isKeyNumber;
  final bool isDone;
  final bool readOnly;
  final bool digitsOnly;
  final double? width;
  final bool isDateTime;
  final bool isMultiLine;
  final  Function(String?)? onSaved;
  final void Function()?  onTap;
  final String? Function(String?)? validate;
  final Icon? icon;
  final int? maxLength;
  final TextEditingController? controller;
  
  const CustomInputText({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onSaved,
    required this.validate,
    this.icon,
    this.width,
    this.maxLength,
    this.descricaoHelper,
    this.onTap,
    this.controller,
    this.isHelper=false,
    this.isDone=false,
    this.isKeyNumber=false,
    this.isMultiLine=false,
    this.digitsOnly=false,
    this.isDateTime=false,
    this.readOnly=false,
  });

  @override
  Widget build(BuildContext context) {
    TextInputType? textInputType;
    if(isKeyNumber){
      textInputType=TextInputType.number;
    }
    else if(isDateTime){
      textInputType=TextInputType.datetime;
      
    }
    else if(isMultiLine){
      textInputType=TextInputType.multiline;
    }
    
    return  Container(
      width: width,

      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(4)
      ),
      margin:const  EdgeInsets.all(8),
      child: TextFormField(
        minLines: isMultiLine?1:null,
        maxLines: isMultiLine?5:1,
        readOnly: readOnly,
        controller: controller,
        onTap:onTap ,
        maxLength: maxLength,
        autovalidateMode:AutovalidateMode.onUserInteraction ,
        decoration:  InputDecoration(
          helper:isHelper? GestureDetector(
            child: const Icon(Icons.help_center),
            onTap: (){
              showDialog(context: context, builder:(context)=>
              CustomAlertDialog(
                apenasBotaoFechar: true,
                titulo: 'Ajuda', 
                descricao: descricaoHelper??'',
                onPressedClose: (){Navigator.of(context).pop();},));
            },):null ,
          border: const OutlineInputBorder(),
          icon: icon,

          hintText: hintText,
          labelText: labelText,
          labelStyle: const TextStyle(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide()
          ),
          
      
        ),
        textInputAction:isDone ? TextInputAction.done:TextInputAction.next,
        inputFormatters: isKeyNumber && digitsOnly?[
          FilteringTextInputFormatter.digitsOnly
        ]:null,
        keyboardType: textInputType,
        onSaved: onSaved,
        validator:validate ,
      ),
    );
  }
}