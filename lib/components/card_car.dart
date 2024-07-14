import 'package:carman/models/car_list.dart';
import 'package:carman/models/caracter_car.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CardCar extends StatelessWidget {
  const CardCar({super.key,
  required this.carro
  });
  final Carro carro;
  

  

  
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ()=>Navigator.of(context).pushNamed(
        AppRoutes.mostrarCarroDetalhes,
        arguments: carro
      ),//TODO
      child: Card(
        elevation: 6,
        shadowColor: const  Color.fromRGBO(49, 44, 81, 1),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(241, 170, 155, 1),
            borderRadius: BorderRadius.all(Radius.circular(6))
            ),
          
          child:  Row(
            children: [
              const Icon(
                Icons.drive_eta,
                color: Color.fromRGBO(40, 36, 67, 1),
                size: 80,
              ),
              Column(
                children: [
                  Text(carro.marca,
                  style: const TextStyle(
                    color:Color.fromRGBO(40, 36, 67, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                   ),
                  ),
                  Row(
                    children: [
                      Text(
                        carro.modelo,
                      style:const  TextStyle(
                        color:Color.fromRGBO(40, 36, 67, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                   ),
                  ),
                 const  SizedBox(width: 10),
                  Text(
                    carro.ano,
                    style: const TextStyle(
                    color:Color.fromRGBO(40, 36, 67, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                   ),
                  ),
                    ],
      
                  )
                ],
              ),
            
              const SizedBox(width: 50),
              IconButton(onPressed: (){
                showDialog(context: context,
                 builder:(context)=> AlertDialog(
                  backgroundColor: const Color.fromRGBO(72, 66, 109, 1),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Provider.of<CarList>(context,listen: false).deletarCarroLista(carro);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                      'Excluir',
                      style: TextStyle(
                        color: Color.fromRGBO(241, 170, 155, 1),
                        fontWeight: FontWeight.bold,
                        fontSize:20.0 
                      ),)),
                    const SizedBox(width: 80),
                    TextButton(
                      //TODO: mudar a cor quando pressionado
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                      child: const Text('Cancelar',
                      style: TextStyle(
                        color: Color.fromRGBO(241, 170, 155, 1),
                        fontWeight: FontWeight.bold,
                        fontSize:20.0 
                      ),)
                    )
                    
                  ],
                  title: const Text("Atenção",style: TextStyle(color: Color.fromRGBO(241, 170, 155, 1)),),
                  contentPadding: const EdgeInsets.all(20.0),
                  actionsPadding: const EdgeInsets.all(10),
                  content: const Text(
                    "Você realmente deseja excluir esse carro?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(241, 170, 155, 1)
                    ),
                    
                  ),
                 )
                );
                
              }, icon: const Icon(Icons.delete,color: Color.fromRGBO(40, 36, 67, 1),))
            ],
      
          ),
        )
      
      ),
    );
  }
}