import 'dart:io';
import 'package:carman/components/cards/custom_card.dart';
import 'package:carman/components/custom_circular_progress.dart';
import 'package:carman/components/empty_list.dart';
import 'package:carman/components/list_view_objects.dart';
import 'package:carman/models/carro/car_list.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class GaragePage extends StatefulWidget {
  const GaragePage({super.key});

  @override
  State<GaragePage> createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garagem'),
         ),
      
      
      body: FutureBuilder(
        future: Provider.of<CarList>(context,listen: false).initRepository(CarList.tableName),
        builder: (ctx,snapShot) {
          final provider=Provider.of<CarList>(context,listen: true);
          final List<Carro> carros =provider.lista;
          return snapShot.connectionState==ConnectionState.waiting
        ?const CustomCircularProgress()
        :ListViewObjects(
          floatingButtonRoute: AppRoutes.addCarPage, 
          emptyList: const EmptyList(
            icon: Icons.garage_sharp,
            text: "Sua garagem está vazia\nClique no '+' para adicionar um carro",), 
          lista: carros, 
          isListEmpty: provider.isListaEmpty, 
          itemBuilder: (BuildContext context,int index ){
            return CustomCard<Carro>(
              object: carros[index],
              ontap:()=> Navigator.of(context).pushNamed(
                AppRoutes.mostrarCarroDetalhes,
               arguments: carros[index]),
              icon: Icons.drive_eta,
              avatar: carros[index].imageCar.isNotEmpty?CircleAvatar(
                backgroundImage: FileImage(File(carros[index].imageCar)),
                radius: 60.0,
                ):null,
              principalText:carros[index].apelido.isEmpty? carros[index].marca:carros[index].apelido,
              leftText: carros[index].modelo,
              righttext: carros[index].ano.toString(),
              tipoAlert: "carro", 
              removeObjectLista: provider.removeObjectLista,
             
              );
          },
        
        
             
        
            );}
      )
    );
  }
}