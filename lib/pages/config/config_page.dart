import 'package:carman/components/uso_geral/custom_button.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter/material.dart';



class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),),
        body:  Center(
          child: Column(
            children: [
              CustomButton(
                margin: 10,
                onPressed:()=> Navigator.of(context).pushNamed(AppRoutes.editTags),
                label: "Gerenciar Serviços",
                icon:const  Icon(Icons.engineering),
                
               
               ),
               
                
                
                
              
              
            ],
          ),
        ), 
        
      );
  
  }
}