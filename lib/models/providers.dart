import 'package:carman/models/carro/car_list.dart';
import 'package:carman/models/config_service.dart';
import 'package:carman/models/lembrete/lembrete_agendado_list.dart';
import 'package:carman/models/lembrete/lembrete_km_list.dart';
import 'package:carman/models/lembrete/lembrete_periodico_list.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomProvider{
  static  MultiProvider multiprovider({required Widget? carman}){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LembreteAgendadoList>(create: (_)=>LembreteAgendadoList()),
        ChangeNotifierProvider<LembreteKmList>(create: (_)=>LembreteKmList()),
        ChangeNotifierProvider<LembretePeriodicoList>(create: (_)=>LembretePeriodicoList()),
        ChangeNotifierProvider<ConfigService>(create: (_)=>ConfigService(),),
        ChangeNotifierProvider<CarList>(create: (_)=>CarList()),
        Provider<NotificationController>(create: (context)=>NotificationController(),)
        
      ],
    child:carman);
  }
}