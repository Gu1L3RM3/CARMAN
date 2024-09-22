import 'package:carman/dataBase/db.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

abstract class ObjectList<T> extends  ChangeNotifier {
  late Database db;
  List<T> _lista=[];
  
  List<T>  get lista => [..._lista];
  bool get isListaEmpty => _lista.isEmpty;
  set setLista(List<T> lista){
    _lista=lista;
  }
  void removeObjectLista(T object,[BuildContext? context]);
  void addObjectFromData(Map<String,Object> data);
  Future<void> initRepository(String table);

  Future<void> insert(String table,Map<String,Object> data)async{
    db=await DB.instance.database;
  
    await db.insert(table, data,conflictAlgorithm: ConflictAlgorithm.replace);

  }
  Future<List<Map<String,dynamic>>> getData(String table)async{
    db=await DB.instance.database;
    return await db.query(table);
  
  }
  Future<int> deleteData({required int id,required String table,required String idName}) async {
    return await db.delete(table, where: '$idName = ?', whereArgs: [id]);
  }
  Future<int> updateData({required Map<String,Object> data,required String table,required String idName}) async {
    return await db.update(table, data,
        where: '$idName = ?', whereArgs: [data[idName]]);
  }
  void adicionarObject(T object){
    
    _lista.add(object);
    
    notifyListeners();
  }

  int  generateId(){
    int newId=_lista.length+1;
    
    return newId;
  }
  void deletarObject(int id){
    int index = id-1;
    
    if(index>=0){
  
      
      _lista.removeAt(index);
      notifyListeners();
    }
    }
  
  

}