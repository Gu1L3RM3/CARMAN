import 'package:carman/components/uso_geral/formularios/custom_input_text.dart';
import 'package:carman/models/config_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTagPage extends StatefulWidget {
  const AddTagPage({super.key});

  @override
  State<AddTagPage> createState() => _AddTagPageState();
}
//TODO: Arrumar bug
class _AddTagPageState extends State<AddTagPage> {
  final _formKey=GlobalKey<FormState>();
  String newTag='';
  
  

  void _submitForm(ConfigService configService){
    final isValid=_formKey.currentState?.validate()??false;
    if(!isValid){
      return;
    }
    
    _formKey.currentState?.save();
    configService.addTag(newTag);
    print(configService.tags);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ConfigService>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close),
            ),
            
          
          title: const Text("Adicionar Serviço"),
          centerTitle: true,
          actions: [GestureDetector(
            onTap: (){
              _submitForm(value);
              
            },
            child: const Text("S A L V A R"),
          )],
        ),
        body: Form(

                          key: _formKey,
                          
                          child: CustomInputText(
                            maxLength: 20,
                            hintText: 'Novo Serviço', 
                            labelText: 'Novo Serviço',
                            onSaved: (tag){
                              newTag=tag??'';
                            }, 
                            // ignore: no_leading_underscores_for_local_identifiers
                            validate: (_tag){
                              final novaTag=_tag??'';
                              if(novaTag.trim().isEmpty){
                                return 'Tag inválida';
                              }
                              if(value.tagExiste(novaTag.trim())){
                                return 'Essa tag já existe';
                              }
                              return null;}
                              ),
                        ),
      ),
    ); 
      
  
  
}
}