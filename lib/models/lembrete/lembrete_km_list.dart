import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/object_list.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';

class LembreteKmList extends ObjectList<LembreteKmRodado>{
  static String tableName='LembreteKmList';
  Future<int> criaNotificacao({
    required String tag,
    required int kmRodado,//do lembrete
    required int mediaKm,//do carro
    required int carroId,
    required TimeOfDay timeOfDay})async{
     
      double tempo=kmRodado/mediaKm;
      int mes=30;
      int dias=(tempo*mes).round();
      DateTime date=DateTime.now().add(Duration(days: dias));     


      return NotificationController.showScheduleNotificationWithActions(
        title: "Lembrete por Km rodado",
        body: "tipo: $tag",
        payload:"$carroId" ,
        timeOfDay: timeOfDay,
        channelIdSchedule: "scheduleToDo",
        channelNameSchedule: "Lembrete KmRodado",
        date: date, 
        confirmButton: "Verificar",
        cancelButton: "Fechar");
    
   }
  @override
  void addObjectFromData( Map<String,Object> data)async{
    int id=generateId();
    var timeList=(data[Lembrete.timeOfDayName] as String).split(':');
    var intTimeList=timeList.map((n)=>int.parse(n)).toList();
    TimeOfDay time=TimeOfDay(hour: intTimeList[0], minute: intTimeList[1]);

    int carroId=data[Lembrete.carroIdName]as int;
    int kmRodado=data[LembreteKmRodado.kmRodadoName]as int;
    int kmRodadoMesCarro=data[LembreteKmRodado.kmMesCarro] as int;
    String tag=data[Lembrete.tagName] as String;

    int idNotificacao=await criaNotificacao(
        tag: tag,
        carroId: carroId,
        timeOfDay: time,
        mediaKm: kmRodadoMesCarro,
        kmRodado: kmRodado
        ,
        );

    
    var dataInsert=data;
    dataInsert.remove(LembreteKmRodado.kmMesCarro);
    dataInsert[Lembrete.idName]=id;
    dataInsert[Lembrete.idNotificacaoName]=idNotificacao;
    await insert(tableName, dataInsert);

    LembreteKmRodado newLembrete=LembreteKmRodado(
      idNotificacao: idNotificacao,
      carroId: carroId,
      kmRodado:data[LembreteKmRodado.kmRodadoName] as int, 
      timeOfDay: time, 
      tag: tag, 
      observacao: data[Lembrete.observacaoName] as String, 
      id: id);

    adicionarObject(newLembrete);
  }
  @override
  void removeObjectLista(LembreteKmRodado object,[BuildContext? context]) async {
    int id=object.id;
    await deleteData(id: id, table: LembreteKmList.tableName, idName: Lembrete.idName);
    deletarObject(id);
  }
  
  @override
  Future<void> initRepository(String table)async {

   final  dataList= await getData(table);
   setLista=dataList.map((item){
    //formata TimeOfDay
    var timeList=(item[Lembrete.timeOfDayName] as String).split(':');
    var intTimeList=timeList.map((n)=>int.parse(n)).toList();
    TimeOfDay time=TimeOfDay(hour: intTimeList[0], minute: intTimeList[1]);

    return LembreteKmRodado(
      id: item[Lembrete.idName] as int,
      carroId: item[Lembrete.carroIdName] as int,
      idNotificacao: item[Lembrete.idNotificacaoName] as int,
      observacao:item[Lembrete.observacaoName] as String,
      tag: item[Lembrete.tagName]as String,
      timeOfDay: time,
      kmRodado: item[LembreteKmRodado.kmRodadoName],
   );}).toList();
  }

}