import 'package:flutter/material.dart';


class CustomLinearProgressBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;
  const CustomLinearProgressBar({
    super.key,
    required this.width,
    required this.height,
    required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color:const  Color.fromARGB(255, 68, 68, 68)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Container(
            width: width * progress,
            decoration: BoxDecoration(
              image:const  DecorationImage(
                image: AssetImage('assets/street.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          
          ),
          Container(
            alignment: Alignment.center,
            child: progress< 0.1?Text("Barra de progresso : ${progress*100}%"):null,
          )
          
          
        ],
      ),
    );
  }
}
