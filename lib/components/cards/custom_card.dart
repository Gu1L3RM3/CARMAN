import 'package:carman/components/uso_geral/custom_alert_dialog.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/lembrete/lembrete_agendado_list.dart';
import 'package:carman/models/lembrete/lembrete_km_list.dart';
import 'package:carman/models/lembrete/lembrete_periodico_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class CustomCard<T> extends StatelessWidget {
  final Function()? ontap;
  final IconData icon;
  final String principalText;
  final String leftText;
  final String righttext;
  final String tipoAlert;
  final Widget? avatar;
  final T object;
  final void  Function(T obj,[BuildContext? context]) removeObjectLista;
  const CustomCard({
    super.key,
    this.ontap,
    this.avatar,
    required this.object,
    required this.icon,
    required this.principalText,
    required this.leftText,
    required this.righttext,
    required this.tipoAlert,
    required this.removeObjectLista,

  });

  
  @override
  Widget build(BuildContext context) {

    Text texto({required String text,double fontsize=20})=>Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
       fontSize: fontsize,
       ),);

    




    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 6,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6))
            ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              avatar??Icon(icon,size:80 ,),
              Column(
                children: <Widget>[
                  texto(text: principalText),
                  Row(
                    children: [
                      texto(text: leftText),
                      const SizedBox(width: 10),
                      texto(text: righttext),
                  
                    ],
      
                  )
                ],
              ),
            
             
              GestureDetector(onTap: (){
                showDialog(context: context,
                 builder:(context)=> Consumer3<LembreteAgendadoList,LembreteKmList,LembretePeriodicoList>(
                  builder: (context, agendadoList, kmList, periodicoList, child) => CustomAlertDialog(
                    titulo: 'ATENÇÃO', 
                    descricao: "Você realmente deseja excluir esse $tipoAlert",
                    doneText:'Excluir',
                    closeText: 'Cancelar',
                    onPressedDone: ()async{
                      if(object is Carro){
                        int idCar = (object as Carro).id;

                        for(var agendado in agendadoList.lista){
                          if(agendado.carroId==idCar)agendadoList.removeObjectLista(agendado);

                        }
                        for(var kmRodado in kmList.lista){
                          if(kmRodado.carroId==idCar)kmList.removeObjectLista(kmRodado);
                        }
                        for(var periodico in periodicoList.lista){
                          if(periodico.carroId==idCar)periodicoList.removeObjectLista(periodico);

                        }
                        removeObjectLista(object,context);
                   
                   
                      }
                      else{removeObjectLista(object);}
                      
                      
                      Navigator.of(context).pop();
                    },
                    onPressedClose: (){
                      Navigator.of(context).pop();
                    },
                    ),
                 )
                );
                
              }, child: Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0),),
                child: const Icon(Icons.delete,size: 40.0,)
                )
                )
            ],
      
          ),
        )
      
      ),
    );
  }
}

