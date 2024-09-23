
import 'package:flutter/material.dart';


class CustomNavBar extends StatelessWidget {
  final int  paginaAtual;
  final PageController pc;
  const CustomNavBar({super.key,required this.paginaAtual,required this.pc});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        minimum:const  EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(spreadRadius: 0,blurRadius: 10,offset: Offset(0, 5))
            ]
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: BottomNavigationBar(
              elevation: 5,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              enableFeedback: false,
              unselectedItemColor:Theme.of(context).unselectedWidgetColor,
              currentIndex: paginaAtual, 
              iconSize: 40,
              items:const [
                BottomNavigationBarItem(icon: Icon(Icons.notifications),label:'Notificações'),
                BottomNavigationBarItem(icon: Icon(Icons.garage),label:'Garagem'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label:'Configurações')
              ],
              onTap: (pagina){
                pc.animateToPage(pagina, duration: const Duration(milliseconds: 400), curve: Curves.ease);
              },),
          ),
        ),
      );
  }
}