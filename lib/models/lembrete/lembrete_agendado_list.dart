import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/object_list.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';

class LembreteAgendadoList extends ObjectList<LembreteAgendado>{
  static String tableName='LembreteAgendadoList';
  Future<int> criaNotificacao({required String tag,required int carroId,required DateTime dateTime,required TimeOfDay timeOfDay})async{
    return await NotificationController.showScheduleNotificationWithActions(
      title: "Lembrete Agendado",
      body: "tipo: $tag",
      payload: "$carroId",
      channelIdSchedule: "scheduleToDo",
      channelNameSchedule: "Lembrete Agendado",
      date: dateTime,
      timeOfDay: timeOfDay,
      confirmButton: 'Verificar',
      cancelButton: 'Fechar');
    
  }
  @override
  void removeObjectLista(LembreteAgendado object,[BuildContext? context]) async{
    int id=object.id;
    NotificationController.cancelNotification(object.idNotificacao);
    await deleteData(id: id, table: LembreteAgendadoList.tableName, idName: Lembrete.idName);
    deletarObject(id);
  }
  @override
  void addObjectFromData(Map<String, Object> data) async{
    var timeList=(data[Lembrete.timeOfDayName] as String).split(':');
    var intTimeList=timeList.map((n)=>int.parse(n)).toList();
    var dateList=(data[LembreteAgendado.dateTimeName] as String).split('/');
    var intDateList=dateList.map((n)=>int.parse(n)).toList();
    var time=TimeOfDay(hour: intTimeList[0], minute: intTimeList[1]);
    DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);
    int id=generateId();
    int idNotificacao=await criaNotificacao(
        tag:data[Lembrete.tagName] as String,
        carroId:data[Lembrete.carroIdName] as int,
        dateTime: date,
        timeOfDay: time,
         ) ;
    LembreteAgendado newLembrete=LembreteAgendado(
      dateTime:date, 
      carroId: data[Lembrete.carroIdName] as int, 
      timeOfDay: time, 
      tag: data[Lembrete.tagName] as String, 
      observacao: data[Lembrete.observacaoName] as String,
      idNotificacao:idNotificacao,
      id: id);
    var dataInsert=data;
    dataInsert[Lembrete.idName]=id;
    data[Lembrete.idNotificacaoName]=idNotificacao;
    await insert(tableName, dataInsert);
    adicionarObject(newLembrete);
  }
  
  @override
  Future<void> initRepository(String table) async{
    
    final  dataList= await getData(table);
    

    setLista=dataList.map((item){
      //formata o TimeOfDay
      var timeList=(item[Lembrete.timeOfDayName] as String).split(':');
      var intTimeList=timeList.map((n)=>int.parse(n)).toList();
      TimeOfDay time=TimeOfDay(hour: intTimeList[0], minute: intTimeList[1]);
      //fortmata o DateTime
      var dateList=(item[LembreteAgendado.dateTimeName] as String).split('/');
      var intDateList=dateList.map((n)=>int.parse(n)).toList();
      DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);

      return LembreteAgendado(
        id: item[Lembrete.idName] as int,
        carroId: item[Lembrete.carroIdName]as int,
        idNotificacao: item[Lembrete.idNotificacaoName]as int,
        observacao:item[Lembrete.observacaoName]as String,
        tag: item[Lembrete.tagName]as String,
        timeOfDay: time,
        dateTime: date,
   );}).toList();

   
   
  }
  

}