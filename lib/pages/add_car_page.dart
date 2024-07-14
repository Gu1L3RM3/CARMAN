import 'package:carman/components/custom_input_text.dart';
import 'package:carman/models/car_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO mudar cor do botão para voltar
class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey=GlobalKey<FormState>();
  final _formData=<String,Object>{};

  void _submitForm(){
    final isValid=_formKey.currentState?.validate()??false;
    if(!isValid){
      return;
    }
    _formKey.currentState?.save();
    Provider.of<CarList>(
      
      context,
      listen:false,
    ).adicionarCarroFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Adicionar Carro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child:ListView(
            children: [//TODO reduzir o código
              CustomInputText(hintText: 'Modelo', 
              labelText: 'Modelo',
              isKeyNumber: false,
              isDone: false,
              onSaved: (modelo)=>_formData['modelo']=modelo??'',
              validate: (_modelo){
                final modelo =_modelo??'';
                if(modelo.trim().isEmpty){
                  return 'Modelo é obrigatório';
                }
                return null;
              },
              
              ),
              CustomInputText(hintText: 'Marca'
              , labelText: 'Marca', 
              isKeyNumber: false,
              isDone: false,
              onSaved: (marca)=>_formData['marca']=marca ?? '',
              validate: (_marca){
                final marca=_marca??'';
                if (marca.trim().isEmpty){
                  return 'Marca é obrigatório';
                }
                return null;
              },
              

              ),
              CustomInputText(
                hintText: 'Apelido (Opcional)', 
                labelText: 'Apelido', 
                isKeyNumber: false, 
                isDone: false,
                onSaved: (apelido)=>_formData['apelido']=apelido??'', 
                validate: (_apelido){
                  final apelido=_apelido??'';
                  if (apelido.trim().isEmpty){
                    return null;
                  }
                  return null;
                }
                ),
              CustomInputText(hintText: 'Ano', //TODO: tirar o nextFileld desse 
              labelText: 'Ano', 
              isKeyNumber: true,
              isDone: true,
              onSaved: (ano) =>_formData['ano']=ano ?? '' ,
              validate: (_ano) {
                final ano=_ano ?? '';
                final anoInt=int.parse(ano.trim());
                final anoAtual=DateTime.now().year;
                if (ano.trim().isEmpty){
                  return 'Ano é obrigatório';
                }
                else if(anoInt>anoAtual || anoInt<1960){
                  return "Ano inválido";
                }
                return null;
                
              },)
            ],
            ) ,),
      )
      
    );
  }
}