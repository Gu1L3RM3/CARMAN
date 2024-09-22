import 'package:carman/components/custom_form.dart';
import 'package:carman/components/custom_input_text.dart';
import 'package:carman/components/select_tag.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/utils/validations_mixin.dart';
import 'package:flutter/material.dart';

class AddKmRodadoPage extends StatefulWidget {
  final Carro carro;
  final  void Function(Map<String, Object>) addObjectFromData;
  const AddKmRodadoPage({super.key,required this.carro,required this.addObjectFromData});

  @override
  State<AddKmRodadoPage> createState() => _AddKmRodadoPageState();
}

class _AddKmRodadoPageState extends State<AddKmRodadoPage> with ValidationsMixin {
  final formData=<String,Object>{};
  TextEditingController timeOfDayController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    formData[Lembrete.carroIdName]=widget.carro.id;
    formData[LembreteKmRodado.kmMesCarro]=widget.carro.mediaKm;

    return CustomForm(
      showButtons: false,
      formData: formData,
      addObjectFromData: widget.addObjectFromData,
      title: "Adicionar Lembrete",
      children: <Widget>[
        SelectTag(
          icon: const Icon(Icons.home_repair_service_rounded),
          onSaved: (tag)=>formData[Lembrete.tagName]=tag??'',
          title: "Ajuda",
          validate: isNotEmpty,
          
        ),
        CustomInputText(
          maxLength: 6,
          digitsOnly: true,
          isKeyNumber: true,
          hintText: "A cada Km rodado...",
          labelText: "Km Rodado",
          onSaved: (kmRodado)=>formData[LembreteKmRodado.kmRodadoName]=int.parse(kmRodado??''),
          validate: (_kmRodado){
                              final kmRodado=_kmRodado??'';
                              if(kmRodado.trim().isEmpty){
                                return 'Obrigatório';
                              }
                              if((int.parse(kmRodado)/widget.carro.mediaKm)<0.05){
                                return 'O valor deve ser pelo menos 5% do Km/mês do seu carro';
                              }
                              return null;}),
        CustomInputText(
          controller: timeOfDayController,
          hintText: "horário",
          labelText: "horário",
          readOnly: true,
          onTap: ()async{
            final TimeOfDay? timeOfDay=await showTimePicker(
              context: context, 
              initialTime: TimeOfDay.now(),
              
              );
              
            if(timeOfDay!=null){
              setState(() {
                timeOfDayController.text=timeOfDay.format(context);
              });
            }
          },
          onSaved: (horario)=>formData[Lembrete.timeOfDayName]=horario??'',
          validate: isNotEmpty),
        CustomInputText(
          isDone: true,
          maxLength: 200,
          isMultiLine: true,
          hintText: "Observação",
          labelText: "Observação",
          onSaved: (observacao)=>formData[Lembrete.observacaoName]=observacao??'',
          validate: (_)=>null)
        
        
      ]); 
  }
}