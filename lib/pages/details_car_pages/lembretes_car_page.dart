import 'package:carman/components/cards/custom_card.dart';
import 'package:carman/components/cards/km_lembrete_card.dart';
import 'package:carman/components/uso_geral/custom_circular_progress.dart';
import 'package:carman/components/uso_geral/empty_list.dart';
import 'package:carman/components/uso_geral/list_view_objects.dart';
import 'package:carman/models/carro/caracter_car.dart';
import 'package:carman/models/config_service.dart';
import 'package:carman/models/lembrete/caracter_lembrete.dart';
import 'package:carman/models/lembrete/lembrete_agendado_list.dart';
import 'package:carman/models/lembrete/lembrete_km_list.dart';
import 'package:carman/models/lembrete/lembrete_main.dart';
import 'package:carman/models/lembrete/lembrete_periodico_list.dart';
import 'package:carman/pages/add_lembretes/add_agendado_page.dart';
import 'package:carman/pages/add_lembretes/add_km_rodado_page.dart';
import 'package:carman/pages/add_lembretes/add_periodico_page.dart';
import 'package:carman/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


class LembretesCarPage extends StatefulWidget {
  final Carro carro;
  const LembretesCarPage({super.key,required this.carro});

  @override
  State<LembretesCarPage> createState() => _LembretesCarPageState();
}

class _LembretesCarPageState extends State<LembretesCarPage> {

  Future<void> initRepositories(LembreteAgendadoList agendadoList, LembreteKmList kmList,LembretePeriodicoList periodicoList,ConfigService config,)async{
    await agendadoList.initRepository(LembreteAgendadoList.tableName);
    await kmList.initRepository(LembreteKmList.tableName);
    await periodicoList.initRepository(LembretePeriodicoList.tableName);
    await config.initRepository();

  }
  @override
  Widget build(BuildContext context) {

    return  Consumer4<LembreteAgendadoList,LembreteKmList,LembretePeriodicoList,ConfigService>(
        builder: (context, agendadoList, kmList, periodicoList, config, child) =>FutureBuilder(
          future: initRepositories(agendadoList, kmList, periodicoList, config),
          builder: (context,snapshot) {
            List lembretesList=LembreteMain.getLembretesCar(carro: widget.carro, lembreteAgendadoList: agendadoList, lembretePeriodicoList: periodicoList, lembreteKmList: kmList);
            return snapshot.connectionState==ConnectionState.waiting?  const CustomCircularProgress()
            :  ListViewObjects(
              floatingActionButton: SpeedDial(
                backgroundColor: Colors.blueGrey[700],
                animatedIcon: AnimatedIcons.add_event,
                children:<SpeedDialChild> [
                  SpeedDialChild(
                    label: "Lembrete que se repete",
                    onTap: ()=>Navigator.push(
                  context,  
                  PageTransition(
                    child:AddPeriodicoPage(addObjectFromData: periodicoList.addObjectFromData,carro: widget.carro),
                    type: PageTransitionType.bottomToTop,
                    duration: Durations.medium2
                   )
              ),
                    child: Icon(LembretePeriodico.icon),
                  ),
                  SpeedDialChild(
                    label: "Lembrete agendado",
                    onTap: ()=>Navigator.push(
                  context,  
                  PageTransition(
                    child:AddAgendadoPage(addObjectFromData: agendadoList.addObjectFromData,carro: widget.carro),
                    type: PageTransitionType.bottomToTop,
                    duration: Durations.medium2
                   )
              ),
                    child:Icon(LembreteAgendado.icon),
                  ),
                  SpeedDialChild(
                    label: "Lembrete por Km rodado",
                    onTap: ()=>Navigator.push(
                  context,  
                  PageTransition(
                    child:AddKmRodadoPage(addObjectFromData: kmList.addObjectFromData,carro: widget.carro),
                    type: PageTransitionType.bottomToTop,
                    duration: Durations.medium2
                   )
              ),
                    child: Icon(LembreteKmRodado.iconAdd),
                  )
                ],
              ),
              floatingButtonRoute: const HomePage(),
              emptyList: const EmptyList(
                icon: Icons.access_alarm,
                text: "Sua Lista de Lembretes está vazia\nClique no '+' para adicionar um lembrete",),
              lista: lembretesList, 
              isListEmpty: lembretesList.isEmpty, 
              itemBuilder: (BuildContext context,int index ){
                  if(lembretesList[index] is LembreteKmRodado){
                    var lembreteKmRodado=lembretesList[index] as LembreteKmRodado;
                    return KmLembreteCard(lembrete: lembreteKmRodado,);

                  // return CustomCard<LembreteKmRodado>(
                  //   object: lembreteKmRodado,
                  //   icon: LembreteKmRodado.iconEdit,
                  //   principalText: lembreteKmRodado.tag,
                  //   leftText: '${lembreteKmRodado.kmRodado}Km',
                  //   righttext: lembreteKmRodado.timeOfDay.format(context),
                  //   tipoAlert: LembreteKmRodado.tipo,
                  //   removeObjectLista: kmList.removeObjectLista);
                  }
                  if(lembretesList[index] is LembreteAgendado){
                  var lembreteAgendado=lembretesList[index] as LembreteAgendado;
                  return CustomCard<LembreteAgendado>(
                    object: lembreteAgendado,
                    icon: LembreteAgendado.icon,
                    principalText: lembreteAgendado.tag,
                    leftText: DateFormat('dd/MM/yyyy').format(lembreteAgendado.dateTime),
                    righttext: lembreteAgendado.timeOfDay.format(context),
                    tipoAlert: LembreteAgendado.tipo,
                    removeObjectLista: agendadoList.removeObjectLista,
                    );
            
                  }
                  if(lembretesList[index] is LembretePeriodico){
                  var lembretePeriodico=lembretesList[index] as LembretePeriodico;
                  return CustomCard<LembretePeriodico>(
                    object: lembretePeriodico,
                    icon: LembretePeriodico.icon,
                    principalText: lembretePeriodico.tag,
                    leftText: lembretePeriodico.tipoIntervalo,
                    righttext: lembretePeriodico.timeOfDay.format(context),
                    tipoAlert: LembretePeriodico.tipo,
                    removeObjectLista: periodicoList.removeObjectLista,
                    
                    );
                  }
            
                  
                  return null;
                },);
          }
        ),
      );
    
    
    
  }
}