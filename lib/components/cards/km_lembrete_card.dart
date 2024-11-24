import 'package:carman/components/lembretes/custom_progress_indicator.dart';
import 'package:carman/components/uso_geral/custom_alert_dialog.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/lembrete_km_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KmLembreteCard extends StatelessWidget {
  final LembreteKmRodado lembrete;
  final double _borderRadius=10;
  
  const KmLembreteCard({
    super.key,
    required this.lembrete,
    });
  BoxDecoration boxDecoration({Color cor=Colors.amber}){
    return BoxDecoration(
      color: cor,
      borderRadius: BorderRadius.circular(_borderRadius)
    );
  }

  double diferencaDias(){
    DateTime dataAtual=DateTime.now();
    DateTime dataInicial=lembrete.dataInicial;
    DateTime dataFinal=lembrete.date;
    int totalDias=dataFinal.difference(dataInicial).inDays;
    int diasTranscorridos = dataAtual.difference(dataInicial).inDays;
    return diasTranscorridos/totalDias;
  }
  

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius)
              ),
              child: Image.asset("assets/distancia.png",)
            ),
            Column(
              children: [
                Container(
                  //Título
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius)
              ),
                  width: 225,
                  height: 40,
                  child: Text(lembrete.tag,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 225,
                  height: 40,
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius)
                ),
                  child: CustomLinearProgressBar
                  (width: 220, 
                  height: 40, 
                  progress: diferencaDias()
                   ),
                ),

              ],
            ),
            GestureDetector(
              onTap: () async{
               await  showDialog(context: context,
                 builder: (context)=>Consumer<LembreteKmList>(
                  builder: (context, kmList, child) =>CustomAlertDialog(
                    titulo: 'ATENÇÃO', 
                    descricao: "Você realmente deseja excluir esse Lembrete",
                    doneText:'Excluir',
                    closeText: 'Cancelar',
                    onPressedClose: (){
                      Navigator.of(context).pop();
                    },
                    onPressedDone: () {
                       kmList.removeObjectLista(lembrete);
                      Navigator.of(context).pop();

                    },
                    ) ,
                  )
                  );
              },
              child: Container(
                //delete
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius)
              ),
                child: const Icon(Icons.delete,size: 40,),
                
              ),
            )
          ],
        ),

        
      
      ),
    );
  }
}