import 'package:carman/models/financas/caracter_finances.dart';
import 'package:carman/models/lembrete/object_list.dart';
import 'package:flutter/material.dart';

class FinanceList extends ObjectList<Financa>{
  static String tableName="financas";
  @override
  void addObjectFromData(Map<String, Object> data) async{
    var dateList=(data[Financa.dateTimeName] as String).split('/');
    var intDateList=dateList.map((n)=>int.parse(n)).toList();
    DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);
    Financa newFinanca=Financa(
      id:generateId(),
      carroId: data[Financa.carroIdName]as int,
      tag: data[Financa.tagName] as String,
      dateTime: date,
      dinheiro: double.parse(data[Financa.dinheiroName] as String),
      isGanho: data[Financa.isGanhoName]as int);
    await insert(tableName, data);
    adicionarObject(newFinanca);

    

  }

  @override
  Future<void> initRepository(String table) async{
    final  dataList= await getData(table);
    setLista=dataList.map((item){
      
      //fortmata o DateTime
      var dateList=(item[Financa.dateTimeName] as String).split('/');
      var intDateList=dateList.map((n)=>int.parse(n)).toList();
      DateTime date=DateTime(intDateList[2],intDateList[1],intDateList[0]);

      return Financa(
        id:item[Financa.idName],
        carroId: item[Financa.carroIdName],
        tag: item[Financa.tagName],
        dateTime: date,
        dinheiro: double.parse(item[Financa.dinheiroName]),
        isGanho: item[Financa.isGanhoName]);
   }).toList();
  }

  @override
  void removeObjectLista(object, [BuildContext? context]) async{
    int id=object.id;
  
    await deleteData(id: id, table: tableName, idName: Financa.idName);
    deletarObject(id);
  }

}