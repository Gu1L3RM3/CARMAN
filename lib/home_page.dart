import 'package:carman/config_page.dart';
import 'package:carman/garage_page.dart';
import 'package:carman/notify_page.dart';
import 'package:flutter/material.dart';

const cor1=Color.fromRGBO(241, 170, 155, 1);
const cor2=Color.fromRGBO(240, 195, 142, 1);
const cor3=Color.fromRGBO(72, 66, 109, 1);
const cor4=Color.fromRGBO(49, 44, 81, 1);
const cor5=Color.fromRGBO(40, 36, 67, 1);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual=1;
  late PageController pc;


  @override
  void initState() {
    pc=PageController(initialPage: paginaAtual);
    super.initState();
  }
  setPaginaAtual(pagina){
    setState(() {
      paginaAtual=pagina;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cor3,
      body: PageView(
        controller: pc,
        
        onPageChanged: setPaginaAtual,
        children: const[
          NotifyPage(),
          GaragePage(),
          ConfigPage()
        ],
        ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          decoration:const BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                color: cor5,
                blurRadius: 10)
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
            
              currentIndex: paginaAtual, 
              selectedItemColor: cor2,
              unselectedItemColor: cor3,
              backgroundColor: cor4,
              showSelectedLabels: false,
              showUnselectedLabels: false,
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
      ),
    );
  }
}