import 'package:carman/components/navigators/custom_nav_bar.dart';
import 'package:carman/pages/config/config_page.dart';
import 'package:carman/pages/garagem/garage_page.dart';

import 'package:carman/pages/notify/notify_page.dart';
import 'package:flutter/material.dart';



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
    
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const[
          NotifyPage(),
          GaragePage(),
          ConfigPage()
        ],
        ),
      
      bottomNavigationBar: CustomNavBar(paginaAtual: paginaAtual, pc: pc)
    );
  }
}