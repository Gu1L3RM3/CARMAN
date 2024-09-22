import 'package:carman/components/custom_form.dart';
import 'package:carman/components/custom_input_text.dart';
import 'package:carman/components/select_tag.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/utils/validations_mixin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAgendadoPage extends StatefulWidget {
  final Carro carro;
  final  void Function(Map<String, Object>) addObjectFromData;
  const AddAgendadoPage({super.key,required this.carro,required this.addObjectFromData});

  @override
  State<AddAgendadoPage> createState() => _AddAgendadoPageState();
}

class _AddAgendadoPageState extends State<AddAgendadoPage> with ValidationsMixin {
  final formData=<String,Object>{};
  TextEditingController dateTimeController=TextEditingController();
  TextEditingController timeOfDayController=TextEditingController();
  @override
  Widget build(BuildContext context) {//TODO:Mudar as Strings estáticas para os Caracter Lembretes
    formData[Lembrete.carroIdName]=widget.carro.id;
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
          controller: dateTimeController,
          hintText: "Escolha uma data",
          labelText: "Data",
          readOnly: true,
          onTap: ()async{
            const  int limitYear=50;
            final DateTime? dateTime=await showDatePicker(
              context: context,
              firstDate: DateTime.now().add(const Duration(days: 1)), 
              lastDate: DateTime(DateTime.now().year+limitYear));
            if(dateTime!=null){
              setState(() {
                dateTimeController.text=DateFormat('dd/MM/yyyy').format(dateTime);
              });
            }
          },
          onSaved: (data)=>formData[LembreteAgendado.dateTimeName]=data??'',
          validate: isNotEmpty),
        CustomInputText(
          controller: timeOfDayController,
          hintText: "horário",
          labelText: "horário",
          readOnly: true,
          onTap: ()async{
            final TimeOfDay? timeOfDay=await showTimePicker(
              context: context, 
              initialTime: TimeOfDay.now(),//TODO:horario preferido
              
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