import 'package:carman/dataBase/db.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; 

class ConfigService extends ChangeNotifier{
  static String tableName="configService";
  static String tagName="tag";
  static String idName="id";

  late Database db;
  
  
  // ignore: prefer_final_fields
  List _tags=[
        ['Oleo',0],
        ['Pastilha',1],
        ['Filtro',2],];
  

  List<List<Object>>get  tags=>[..._tags];
  
  

  Future<void> initRepository()async{
    
    db=await DB.instance.database;
    var data= await db.query(tableName);
    
    for(Map<String, Object?>  item in data){
      var tagItem=[item[tagName] as String,item[idName] as int];
      if(tagExiste(tagItem[0]as String)==false)_tags.add(tagItem);
    }
    
  }

  
  
  
  bool tagExiste(String tag){
    List tagList=_tags.map((tg)=>tg[0].toString()).toList();
    return tagList.contains(tag);
  }
  int generateId(){
    List idList=_tags.map((tag)=>tag[1]).toList();
    return idList.last+1;
  }
  bool tagCanRemove(String tag){
    return tagsCanRemove().contains(tag);
  }
  List tagsCanRemove(){
    return _tags.map((tag){
      if(int.parse(tag[1].toString())>2){
        return tag[0];
      }
    }).toList();
  }
  //TAGS
  void addTag(String tag)async{
    int id=generateId();
    var data={idName:id,tagName:tag};
    if(tagExiste(tag)==false){
      _tags.add([tag,id]);
       
       db=await DB.instance.database;
       await db.insert(tableName, data,conflictAlgorithm: ConflictAlgorithm.replace);
       notifyListeners();}
  }
  
  void removeTag(int id)async {
    _tags.removeWhere((tg)=>tg[1]==id);
    await db.delete(tableName, where: '$idName = ?', whereArgs: [id]);
    notifyListeners();
  }
  
  


}