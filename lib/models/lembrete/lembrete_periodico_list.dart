import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/object_list.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LembretePeriodicoList extends ObjectList<LembretePeriodico>{
  static String tableName="LembretePeriodicoList";
  Future <int> criaNotificacao({
    required String tipoIntervalo,
    required String tag,
    required DateTime dataInicial,
    required TimeOfDay timeOfDay,
    required int carroId,
    })async{
    DateTimeComponents dateTimeComponents;
    if(tipoIntervalo==LembretePeriodico.tipoIntervaloList[0]){
      //semanalmente
      dateTimeComponents=DateTimeComponents.dayOfWeekAndTime;
    }
    if(tipoIntervalo==LembretePeriodico.tipoIntervaloList[1]){
      //mensalmente
      
      dateTimeComponents=DateTimeComponents.dayOfMonthAndTime;
    }
    if(tipoIntervalo==LembretePeriodico.tipoIntervaloList[3]){
      return await NotificationController.showSemestralPeriodic(
      title: "Lembrete Periódico",
      body: "tipo: $tag",
      payload: "$carroId",
      channelIdSchedule: "schedulePeriodicToDo",
      channelNameSchedule: "Lembrete Periódico",
      initialDate: dataInicial,
      timeOfDay: timeOfDay,
      confirmButton: 'Verificar',
      cancelButton: 'Fechar');
    }
    
    
    //anualmente
    dateTimeComponents=DateTimeComponents.dateAndTime;
    
    return await NotificationController.showSchedulePeriodic(
      title: "Lembrete Periódico",
      body: "tipo: $tag",
      payload: "$carroId",
      channelIdSchedule: "schedulePeriodicToDo",
      channelNameSchedule: "Lembrete Periódico",
      initialDate: dataInicial,
      dateTimeComponents: dateTimeComponents,
      timeOfDay: timeOfDay,
      confirmButton: 'Verificar',
      cancelButton: 'Fechar');
  }
  @override
  void addObjectFromData(Map<String, Object> data)async {
    int id=generateId();
    
    var timeList=(data[Lembrete.timeOfDayName]as String).split(':');
    TimeOfDay time=TimeOfDay(hour: int.parse(timeList[0]), minute: int.parse(timeList[1]));

    var dateList=(data[LembretePeriodico.dataInicialName] as String).split('/');
    var intDateList=dateList.map((n)=>int.parse(n)).toList();
    DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);

    int idNotificacao=await criaNotificacao(
        carroId: data[Lembrete.carroIdName] as int,
        dataInicial: date,
        tag:data[Lembrete.tagName] as String,
        timeOfDay: time,
        tipoIntervalo: data[LembretePeriodico.tipoIntervaloName] as String,
      );


    LembretePeriodico newLembrete=LembretePeriodico(
      tipoIntervalo: data[LembretePeriodico.tipoIntervaloName] as String,
      
      carroId: data[Lembrete.carroIdName] as int, 
      timeOfDay: time,
      tag: data[Lembrete.tagName] as String, 
      observacao: data[Lembrete.observacaoName] as String,
      dataInicial:date ,
      id: id,
      idNotificacao:idNotificacao
      );
    var dataInsert=data;
    dataInsert[Lembrete.idName]=id;
    dataInsert[Lembrete.idNotificacaoName]=idNotificacao;
    await insert(tableName, dataInsert);
    adicionarObject(newLembrete);
    
  }

  @override
  void removeObjectLista(LembretePeriodico object,[BuildContext? context]) async{
    int id=object.id;
    NotificationController.cancelNotification(object.idNotificacao);
    await deleteData(id: id,idName: Lembrete.idName,table: LembretePeriodicoList.tableName);
    deletarObject(id);
  }
  
  @override
  Future<void> initRepository(String table) async{
    
    final  dataList= await getData(table);


    setLista=dataList.map((item){
    var timeList=(item[Lembrete.timeOfDayName]as String).split(':');
    TimeOfDay time=TimeOfDay(hour: int.parse(timeList[0]), minute: int.parse(timeList[1]));
    var dateList=(item[LembretePeriodico.dataInicialName] as String).split('/');
    var intDateList=dateList.map((n)=>int.parse(n)).toList();
    DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);
    return LembretePeriodico(
      id: item[Lembrete.idName] as int,
      carroId: item[Lembrete.carroIdName]as int ,
      dataInicial: date,
      idNotificacao: item[Lembrete.idNotificacaoName] as int,
      observacao:item[Lembrete.observacaoName] as String,
      tag: item[Lembrete.tagName] as String,
      timeOfDay: time,
      tipoIntervalo: item[LembretePeriodico.tipoIntervaloName]as String,
   );}).toList();
    
  }
}