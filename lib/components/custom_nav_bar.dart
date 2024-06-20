import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int  paginaAtual;
  final PageController pc;
  const CustomNavBar({super.key,required this.paginaAtual,required this.pc});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          decoration:const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(40, 36, 67, 1),
                offset: Offset(0, 8),
                blurRadius: 30)
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
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