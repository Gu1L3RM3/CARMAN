import 'package:carman/components/uso_geral/floating_add_object.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListViewObjects extends StatefulWidget {
  final Widget floatingButtonRoute;
  final Widget emptyList;
  final List lista;
  final bool isListEmpty;
  final Widget? floatingActionButton;
  final Widget? Function(BuildContext, int) itemBuilder;
  const ListViewObjects({
    super.key,
    required this.floatingButtonRoute,
    required this.emptyList,
    required this.lista,
    required this.isListEmpty,
    required this.itemBuilder,
    this.floatingActionButton,

  });

  @override
  State<ListViewObjects> createState() => _ListViewObjectsState();
}

class _ListViewObjectsState extends State<ListViewObjects> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      floatingActionButton:widget.floatingActionButton??FloatingAddObject(
        funcao:()=>Navigator.push(
          context,  
          PageTransition(
            child:widget.floatingButtonRoute,
            type: PageTransitionType.bottomToTop,
            duration: Durations.medium2
           )
      )
      ),
      body: widget.isListEmpty
      ?  widget.emptyList
        
      :Padding(
        padding:  const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.lista.length,
          itemBuilder:widget.itemBuilder
        ),
      ),
      
      
     

    );
  }
}