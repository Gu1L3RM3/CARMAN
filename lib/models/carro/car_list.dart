import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/lembrete/object_list.dart';
import 'package:flutter/material.dart';


class CarList extends ObjectList<Carro> {
  static  String tableName='carList';
  @override
  Future<void> initRepository(String table)async{
   final  dataList= await getData(table);
   setLista=dataList.map((item)=>Carro(
    ano: item[Carro.anoName],
    apelido: item[Carro.apelidoName],
    modelo: item[Carro.modeloName],
    marca: item[Carro.marcaName],
    id:item[Carro.idName],
    mediaKm: item[Carro.mediaKmName],
    odometro: item[Carro.odometroName],
    imageCar: item[Carro.imagePath],
   )).toList();
  }
  @override
  void addObjectFromData( Map<String,Object> data)async {
    int id=generateId();
    final newCar=Carro(
      id:id,
      marca: data[Carro.marcaName] as String, 
      modelo: data[Carro.modeloName]as String,
      apelido: data[Carro.apelidoName] as String,
      ano: data[Carro.anoName]as int,
      odometro:data[Carro.odometroName]as int,
      mediaKm:data[Carro.mediaKmName]as int,
      imageCar: data[Carro.imagePath] as String,
       );
    var dataInsert=data;
    dataInsert[Carro.idName]=id;
    await insert(tableName, dataInsert);
    adicionarObject(newCar);
    notifyListeners();

  }

  void editObjectFromData( Map<String,Object> data)async{
  
    int id=data[Carro.idName]as int ;
    for (Carro car in lista) {
        if(car.id==id){
          car.ano=data[Carro.anoName] as int;
          car.apelido=data[Carro.apelidoName]as String;
          car.marca=data[Carro.marcaName] as String;
          car.mediaKm=data[Carro.mediaKmName] as int;
          car.odometro=data[Carro.odometroName]as int;
          car.modelo=data[Carro.modeloName] as String;
          car.imageCar=data[Carro.imagePath] as String;
        }
    }
    var dataInsert=data;
    dataInsert[Carro.idName]=id;
    await updateData(data: dataInsert,idName: Carro.idName,table: CarList.tableName);
    notifyListeners();

    
  }
  @override
  void removeObjectLista(Carro object,[BuildContext? context])async {
    int id=object.id;
    await deleteData(id: id,idName: Carro.idName,table: CarList.tableName);
    deletarObject(id);
    
  }
  
  Carro getCar(int id){
    if(lista.isNotEmpty){
      for (Carro carro in lista){
        if(carro.id==id)return carro;
      }
    }
    throw Error.safeToString("Não existe esse carro");
  }
  
  }
 

    
    
  

  
  
  
  


  
  
  

