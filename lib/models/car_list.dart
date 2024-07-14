import 'package:carman/adapters/carros_adapters.dart';
import 'package:carman/models/caracter_car.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class CarList extends ChangeNotifier{
  List <Carro> _carros=[];
  late LazyBox box;

  List <Carro> get carros => [..._carros];
  bool get isGarageEmpty => _carros.isEmpty;
  CarList(){
    _startCarList();
  }
  _startCarList()async{
    await _openBox();
    await _readCarList();

  }

  _openBox()async{
    Hive.registerAdapter(CarrosAdapter());
    box=await Hive.openLazyBox<Carro>("CARLIST");
  }
  _readCarList(){
    // ignore: avoid_function_literals_in_foreach_calls
    box.keys.forEach((carro)async{
      Carro c = await box.get(carro);
      _carros.add(c);
      notifyListeners();
    });
  }

  void adicionarCarroFromData(Map<String,Object> data){

    final newCar=Carro(
      id:generateId(),
      marca: data['marca'] as String, 
      modelo: data['modelo']as String,
      apelido: data['apelido'] as String,
      ano: data['ano']as String);
    box.put(newCar.id, newCar);
    adicionarCarro(newCar);
    
  }

  String generateId(){
    int id=0;
    if(_carros.isEmpty){
      return id.toString();
    }
    else{
      List<int> idList= _carros.map((carro)=>int.parse(carro.id)).toList();
      id=idList.last+1;
      return id.toString();
    }}
  
  void deletarCarroLista(Carro carro){
    int index = _carros.indexWhere((c)=>c.id==carro.id);
    if(index>=0){
      _carros.removeWhere((c)=>c.id==carro.id);
      box.delete(carro.id);
      notifyListeners();
    }
  }

  void createInitialData(){
    _carros=[];
    
  }


  
  void adicionarCarro(Carro carro){
    _carros.add(carro);
    notifyListeners();
  }
  

}