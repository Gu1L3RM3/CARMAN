import 'package:carman/components/custom_circular_progress.dart';
import 'package:carman/components/custom_form.dart';
import 'package:carman/components/custom_input_text.dart';
import 'package:carman/models/carro/car_list.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/utils/validations_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDetailsCarPage extends StatefulWidget  {
  final Carro carro ;
  const EditDetailsCarPage({super.key,required this.carro});

  @override
  State<EditDetailsCarPage> createState() => _EditDetailsCarPageState();
}

class _EditDetailsCarPageState extends State<EditDetailsCarPage>with ValidationsMixin {
  final  _formData=<String, Object>{};
  //TODO:otimizar isso
  final TextEditingController apelidoController=TextEditingController();
  final TextEditingController odometroController=TextEditingController();
  final TextEditingController marcaController=TextEditingController();
  final TextEditingController anoController=TextEditingController();
  final TextEditingController modeloController=TextEditingController();
  final TextEditingController kmMedioController=TextEditingController();

  @override
  void initState() {
    apelidoController.text=widget.carro.apelido;
    marcaController.text=widget.carro.marca;
    odometroController.text=widget.carro.odometro.toString();
    anoController.text=widget.carro.ano.toString();
    modeloController.text=widget.carro.modelo;
    kmMedioController.text=widget.carro.mediaKm.toString();
    _formData['id']=widget.carro.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1,milliseconds: 30)),
      builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting
      ?const CustomCircularProgress()
       :CustomForm(
          title: 'Adicionar Carro',
          showButtons: true,
          showSnackBar: true,
          showAppBar: false,
          formData: _formData,
          addObjectFromData:Provider.of<CarList>(context,listen: false).editObjectFromData,
          children:<Widget> [
              CustomInputText(
                controller: modeloController,
                maxLength: 10,             
                icon: const Icon(Icons.list),
                hintText: 'Modelo', 
                labelText: 'Modelo',
                onSaved: (modelo)=>_formData['modelo']=modelo??'',
                validate: isNotEmpty,
              
              ),
              CustomInputText(
                controller: marcaController,
                maxLength: 12,
                icon:const Icon(Icons.factory),
                hintText: 'Marca',
                labelText: 'Marca',
                onSaved: (marca)=>_formData['marca']=marca ?? '',
                validate: isNotEmpty,
              
          
              ),
              CustomInputText(
                controller: apelidoController,
                maxLength: 10,
                icon: const Icon(Icons.local_offer_rounded),
                hintText: 'Apelido (Opcional)', 
                labelText: 'Apelido', 
                onSaved: (apelido)=>_formData['apelido']=apelido??'', 
                validate: isNotEmpty
                ),
              CustomInputText(
                controller: anoController,
                hintText: 'Ano', 
                icon: const Icon(Icons.edit_calendar_rounded),
                labelText: 'Ano', 
                isKeyNumber: true,
                digitsOnly: true,
                onSaved: (ano) =>_formData['ano']=int.parse(ano ?? '') ,
                validate: (_ano) {
                final ano=_ano ?? '';
                if (ano.trim().isEmpty){
                  return 'Ano é obrigatório';
                }
                if(int.parse(ano.trim())<1960 || int.parse(ano.trim())>DateTime.now().year+1){
                  return 'Ano inválido';
                }
                return null;
                
              },),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Expanded>[
                  Expanded(
                    child: CustomInputText(
                      controller: odometroController,
                      maxLength: 6,
                      icon: const Icon(Icons.add_road_sharp),
                      hintText: 'Odômetro', 
                      labelText: 'Odômetro',
                      descricaoHelper: '''
      Insira quantos quilômetros rodados tem seu carro''',
                      isHelper: true,
                      isKeyNumber: true, 
                      digitsOnly: true,
                      onSaved: (odometro)=>_formData['odometro']=int.parse(odometro??''), 
                      validate: isNotEmpty,
                      ),
                  ),
                  Expanded(
                    child: CustomInputText(
                        controller: kmMedioController,
                        maxLength: 6,
                        hintText: "km/mês", 
                        labelText: "km/mês", 
                        descricaoHelper:
      '''Insira quantos quilômetros você anda por mês.
      Não se preocupe em dar valores exatos.
      Você pode alterar esse valor posteriormente''' ,
                        isDone: true, 
                        isKeyNumber: true, 
                        digitsOnly: true, 
                        isHelper:true,
                        onSaved: (mediaKm)=>_formData['mediaKm']=int.parse(mediaKm??'') , 
                        validate:isNotEmpty ),
                  ),
                ],
              ),
              
              
              
              
            ],
            ),
    ) ;
    
  }
}