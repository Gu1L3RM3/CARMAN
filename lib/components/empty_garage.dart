import 'package:flutter/material.dart';

class EmptyGarage extends StatelessWidget {
  const EmptyGarage({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Padding(
      padding: EdgeInsets.only(top:250 ,left: 20,right: 20),
      child:  Column(
              children: [
                Center(
                  child: Icon(
                  Icons.garage_sharp,
                  size: 80,
                  color:Color.fromRGBO(49, 44, 81, 1)),
                ),
                Text(
                  'Sua Garagem esta vazia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
          
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(49, 44, 81, 1)
                     ),
                  
                ),
                Text(
                  "Clique no '+' para adicionar um carro",
                  textAlign: TextAlign.start,
                  style: TextStyle(
          
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(49, 44, 81, 1)
                     ),
                  
                )
                
              ],
            
      ),
    );
      
    
  }
}