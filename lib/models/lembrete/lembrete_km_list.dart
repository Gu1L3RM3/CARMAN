import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/object_list.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LembreteKmList extends ObjectList<LembreteKmRodado>{
  static String tableName='LembreteKmList';
  Future<int> criaNotificacao({
    required String tag,
    required DateTime date,
    required int carroId,
    required TimeOfDay timeOfDay})async{
     
          


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

    double tempo=kmRodado/kmRodadoMesCarro;
    int mes=30;
    int dias=(tempo*mes).round();
    DateTime date=DateTime.now().add(Duration(days: dias)); 
    DateTime dataInicial=DateTime.now();  

    int idNotificacao=await criaNotificacao(
        tag: tag,
        carroId: carroId,
        timeOfDay: time,
        date:date
        
        );

    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    String formattedDateInicial=DateFormat('dd/MM/yyyy').format(dataInicial);
    var dataInsert=data;
    dataInsert.remove(LembreteKmRodado.kmMesCarro);
    dataInsert[Lembrete.idName]=id;
    dataInsert[Lembrete.idNotificacaoName]=idNotificacao;
    dataInsert[LembreteKmRodado.dateName]=formattedDate;
    dataInsert[LembreteKmRodado.dateInicial]=formattedDateInicial;
    await insert(tableName, dataInsert);

    LembreteKmRodado newLembrete=LembreteKmRodado(
      idNotificacao: idNotificacao,
      carroId: carroId,
      kmRodado:data[LembreteKmRodado.kmRodadoName] as int, 
      timeOfDay: time, 
      tag: tag,
      date:date,
      dataInicial: dataInicial , 
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

    var dateList=(item[LembreteAgendado.dateTimeName] as String).split('/');
    var intDateList=dateList.map((n)=>int.parse(n)).toList();
    DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);

    var dataListInicial=(item[LembreteAgendado.dateTimeName] as String).split('/');
    var intDataListInicial=dataListInicial.map((n)=>int.parse(n)).toList();
    DateTime dataInicial=DateTime(intDataListInicial[2],intDataListInicial[1],intDataListInicial[0]);
    

    return LembreteKmRodado(
      id: item[Lembrete.idName] as int,
      carroId: item[Lembrete.carroIdName] as int,
      date: date,
      dataInicial: dataInicial,
      idNotificacao: item[Lembrete.idNotificacaoName] as int,
      observacao:item[Lembrete.observacaoName] as String,
      tag: item[Lembrete.tagName]as String,
      timeOfDay: time,
      kmRodado: item[LembreteKmRodado.kmRodadoName],
   );}).toList();
  }

}