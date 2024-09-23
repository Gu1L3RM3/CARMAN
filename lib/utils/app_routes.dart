import 'package:carman/pages/garagem/add_car_page.dart';
import 'package:carman/pages/config/add_tag_page.dart';
import 'package:carman/pages/config/edit_tags_page.dart';
import 'package:carman/pages/details_car_pages/details_car_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Widget addCarPage= AddCarPage();
  static Widget editTagsPage=const EditTagsPage();
  static const Widget detailsCarPage=DetailsCarPage();
  static const Widget addServicePage=AddTagPage();
  static const adicionarLembrete='/lembrete-adicionar';
  static const adicionarCarro='/carro-adicionar';
  static const mostrarCarroDetalhes='/carro-detalhes';
  static const editTags='/config-editTags';
  static const addTagPage='/config-addTag';

  static Map<String, Widget Function(BuildContext)> routes={
    adicionarCarro:(ctx)=>addCarPage,
    editTags:(ctx)=>editTagsPage,
    mostrarCarroDetalhes:(ctx)=>detailsCarPage,
    addTagPage:(ctx)=>addServicePage
  };
  
}