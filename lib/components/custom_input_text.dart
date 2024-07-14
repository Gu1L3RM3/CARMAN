import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputText extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool isKeyNumber;
  final bool isDone;
  final  Function(String?)? onSaved;
  final String? Function(String?)? validate;
  const CustomInputText({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.isDone,
    required this.isKeyNumber,
    required this.onSaved,
    required this.validate
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      decoration:  InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 26, 49, 1) ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(33, 29, 54, 1))
        ),
        hintStyle: const TextStyle(
          color: Color.fromRGBO(37, 33, 61, 1) 
          )

      ),
      textInputAction:isDone ? TextInputAction.done:TextInputAction.next,
      inputFormatters: isKeyNumber?[
        FilteringTextInputFormatter.digitsOnly
      ]:null,
      keyboardType: isKeyNumber ? TextInputType.number:null,
      onSaved: onSaved,
      validator:validate ,
    );
  }
}