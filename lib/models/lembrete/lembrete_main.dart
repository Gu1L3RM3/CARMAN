import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/config_service.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/lembrete_agendado_list.dart';
import 'package:carman/models/lembrete/lembrete_km_list.dart';
import 'package:carman/models/lembrete/lembrete_periodico_list.dart';
class LembreteMain{
  static List getLembretesCar({
    required Carro carro,
    required LembreteAgendadoList lembreteAgendadoList,
    required LembretePeriodicoList lembretePeriodicoList,
    required LembreteKmList lembreteKmList}){
    
    int carId=carro.id;
    List lembretesCar=[];
    
    for (LembreteAgendado lembreteAgendado in lembreteAgendadoList.lista){
      if(lembreteAgendado.carroId==carId){
        lembretesCar.add(lembreteAgendado);
      }
    }
    for(LembreteKmRodado lembreteKm in lembreteKmList.lista ){
      if(lembreteKm.carroId==carId){
        lembretesCar.add(lembreteKm);
      }
    }
    for(LembretePeriodico lembretePeriodico in lembretePeriodicoList.lista ){
      if(lembretePeriodico.carroId==carId){
        lembretesCar.add(lembretePeriodico);
      }
    }
    
    return lembretesCar;
  }
  static Future<void> initRepositories({
    required LembreteAgendadoList lembreteAgendadoList,
    required LembretePeriodicoList lembretePeriodicoList,
    required LembreteKmList lembreteKmList,
    required ConfigService configService,
  })async{

    await configService.initRepository();
    await lembreteAgendadoList.initRepository(LembreteAgendadoList.tableName);
    await lembretePeriodicoList.initRepository(LembretePeriodicoList.tableName);
    await lembreteKmList.initRepository(LembreteKmList.tableName);

    

  }
  
  
  static bool isListaEmpty(List<dynamic> lembretesCar){
    return lembretesCar.isEmpty;

  }

  
  
}