import 'package:flutter/material.dart';

class RoundedCardTileTrans extends StatelessWidget {
  RoundedCardTileTrans({Key? key, required this.text, this.color}) : super(key: key);
  String text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color,
      child: Container(
        width: 85,
        height: 25,
        child: Center(child: Text(text, style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}