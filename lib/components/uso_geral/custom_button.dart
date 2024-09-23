import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Widget? icon;
  final double margin;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.margin=8.0,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(margin),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label:Text(label),
        icon:icon ,

      ),
    );
  }
}