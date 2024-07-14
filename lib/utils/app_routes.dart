import 'package:carman/pages/add_car_page.dart';
import 'package:carman/pages/details_car_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const adicionarCarro='/carro-adicionar';
  static const mostrarCarroDetalhes='/carro-detalhes';

  static Map<String, Widget Function(BuildContext)> routes={
    adicionarCarro:(ctx)=>const AddCarPage(),
    mostrarCarroDetalhes:(ctx)=>const DetailsCarPage()
  };
}