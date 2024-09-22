import 'package:carman/utils/my_snack_bar.dart';
import 'package:flutter/material.dart';


class CustomForm extends StatefulWidget {
  final List<Widget> children;
  final void Function(Map<String, Object> data) addObjectFromData;
  final Map<String,Object> formData;
  final bool showButtons;
  final bool showSnackBar;
  final bool showAppBar;
  final String title;

  const CustomForm({
    super.key,
    required this.formData,
    required this.children,
    required this.title,
    required this.addObjectFromData,
    this.showButtons=true,
    this.showSnackBar=false,
    this.showAppBar=true,
    });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey=GlobalKey<FormState>();
  
  

  void _submitForm(){
    final isValid=_formKey.currentState?.validate()??false;
    if(!isValid){
      return;
    }
    _formKey.currentState?.save();
    
    widget.addObjectFromData(widget.formData);
    widget.showSnackBar ?MySnackbar.showSnackBar(context: context,texto: "Alterações salvas com Sucesso!") :Navigator.of(context).pop();
  }


  

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton:widget.showButtons? FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.save)):null,
      appBar:widget.showAppBar? AppBar(
        leading: IconButton(
          icon:const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),

          ),
        
        title: Text(widget.title),
        actions:widget.showButtons==false? [
          GestureDetector(
            onTap: _submitForm,
            child: const Padding(
              
              padding:  EdgeInsets.only(right: 8.0),
              child:  Text('SALVAR'),
            ))
        ]:null,
        
      ):null,
      body: Form(
          key: _formKey,
          child:ListView(
            padding: const EdgeInsets.all(8),
            children:widget.children,
            ) ,
            ),
    );
  }
}