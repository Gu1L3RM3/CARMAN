import 'package:carman/components/navigators/curved_nav_bar.dart';
import 'package:carman/models/carro/car_list.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/pages/details_car_pages/edit_details_car_page.dart';
import 'package:carman/pages/details_car_pages/lembretes_car_page.dart';
import 'package:carman/pages/details_car_pages/historico_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsCarPage extends StatefulWidget {
  const DetailsCarPage({super.key});

  @override
  State<DetailsCarPage> createState() => _DetailsCarPageState();
}

class _DetailsCarPageState extends State<DetailsCarPage> {
  int paginaAtual=1;
  late PageController pc;
  static Color lembretesColor=Colors.purple;
  static Color mapColor=Colors.amber;
  static Color editColor=Colors.blue;
  Color backgroundAppBar=lembretesColor;
  String textAppBar='Lembretes';

  @override
  void initState() {
    
    pc=PageController(initialPage: paginaAtual);
    super.initState();
  }
  setAppBar(paginaAtual){
    setState(() {
      switch (paginaAtual){
        case 0:
          textAppBar='Histórico';
          backgroundAppBar=mapColor;
          break;
        case 1:
          textAppBar='Lembretes';
          backgroundAppBar=lembretesColor;
          break;
        case 2:
          textAppBar='Editar';
          backgroundAppBar=editColor;
          break;
      }
    });
  }
  setPaginaAtual(pagina){
    setState(() {
      paginaAtual=pagina;
    });
    setAppBar(pagina);
  }
  @override
  Widget build(BuildContext context) {
    final Carro carro;
    if(ModalRoute.of(context)?.settings.arguments is  int){
      int id=ModalRoute.of(context)?.settings.arguments as int;
      carro=Provider.of<CarList>(context).getCar(id);
    }else{
      carro=ModalRoute.of(context)?.settings.arguments as Carro;
    }
    
    return  Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pop();
          },),
        shape: const RoundedRectangleBorder(
          borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)) ),
        backgroundColor: backgroundAppBar,
        title: Text(textAppBar),
      ),
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: [
          HistoricoPage(carro:carro),
          LembretesCarPage(carro:carro),
          EditDetailsCarPage(carro:carro),
        ],
        ),
      bottomNavigationBar:  CurvedNavBar(paginaAtual:paginaAtual,pc:pc),
     
    );
  }
}