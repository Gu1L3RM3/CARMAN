import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class CurvedNavBar extends StatelessWidget {
  final PageController pc;
  final int paginaAtual;
  const CurvedNavBar({super.key,required this.paginaAtual,required this.pc});

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CurvedNavigationBar(
        index: paginaAtual,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).primaryColor,
        animationDuration: const Duration(microseconds: 400),
        items: const <Widget> [
          Icon(Icons.monetization_on,color: Colors.amber),
          Icon(Icons.alarm,color: Colors.purple,),
          Icon(Icons.edit,color: Colors.blue,),
        ],
        onTap: (pagina) {
           pc.animateToPage(pagina, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        ),
    );
  }
}