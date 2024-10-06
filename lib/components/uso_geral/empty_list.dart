import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final IconData icon;
  final String text;
  const EmptyList({
    super.key,
    required this.icon,
    required this.text


  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const  EdgeInsets.only(top:250 ,left: 20,right: 20),
      child:  Column(
              children: [
                Center(
                  child: Icon(
                    icon,
                    size: 80,
                    color: Theme.of(context).shadowColor,
                    
                    
                  ),
                ),
                
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).shadowColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    
                     ),
                  
                )
                
              ],
            
      ),
    );
      
    
  }
}