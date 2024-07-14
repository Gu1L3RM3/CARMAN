import 'package:carman/components/add_car.dart';
import 'package:carman/components/empty_garage.dart';
import 'package:carman/models/car_list.dart';
import 'package:carman/models/caracter_car.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:carman/components/card_car.dart';
import 'package:provider/provider.dart';



class GaragePage extends StatefulWidget {
  const GaragePage({super.key});

  @override
  State<GaragePage> createState() => _GaragePageState();
}

class _GaragePageState extends State<GaragePage> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<CarList>(context);
    final List<Carro> carros =provider.carros;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garagem'),
         ),
      
      floatingActionButton: AddCar(
        funcao:()=> Navigator.of(context).pushNamed(
          AppRoutes.adicionarCarro,
          //arguments=product
        )
      ),
      body: provider.isGarageEmpty
      ? const EmptyGarage()
        
      :Padding(
        padding:  const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: carros.length,
          itemBuilder:(context, index) {
            return CardCar(carro: carros[index],);
          },
        ),
      )
      
     

    );
  }
}