import 'package:carman/components/uso_geral/custom_drop_down.dart';
import 'package:carman/components/uso_geral/formularios/custom_form.dart';
import 'package:carman/components/uso_geral/formularios/custom_input_text.dart';
import 'package:carman/components/lembretes/select_tag.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/utils/validations_mixin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPeriodicoPage extends StatefulWidget  {
  final Carro carro;
  final void Function(Map<String, Object>) addObjectFromData;
  const AddPeriodicoPage({super.key,required this.addObjectFromData,required this.carro});

  @override
  State<AddPeriodicoPage> createState() => _AddPeriodicoPageState();
}

class _AddPeriodicoPageState extends State<AddPeriodicoPage>with ValidationsMixin {
  final formData=<String,Object>{};

  TextEditingController timeOfDayController=TextEditingController();
  TextEditingController dateTimeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    
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
        CustomDropDown(
          validate: isNotEmpty,
          icon: const Icon(Icons.checklist_outlined),
          onSaved: (tipoIntervalo)=>formData[LembretePeriodico.tipoIntervaloName]=tipoIntervalo??'',
          lista: LembretePeriodico.tipoIntervaloList,
          title: "Ajuda"),
        
        CustomInputText(
          controller: dateTimeController,
          hintText: "Escolha uma data inicial",
          labelText: "Data Inicial",
          isHelper: true,
          descricaoHelper: "A partir da data inserida o aplicativo agendará a notificação\ncom o devido intervalo de repetição ",
          readOnly: true,
          onTap: ()async{
            const  int limitYear=50;
            final DateTime? dateTime=await showDatePicker(
              context: context,
              firstDate: DateTime.now(), 
              
              lastDate: DateTime(DateTime.now().year+limitYear));
              
            if(dateTime!=null){
              setState(() {
                dateTimeController.text=DateFormat('dd/MM/yyyy').format(dateTime);
              });
            }
          },
          onSaved: (data)=>formData[LembretePeriodico.dataInicialName]=data??'',
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