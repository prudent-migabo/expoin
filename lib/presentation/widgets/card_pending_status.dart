import 'package:flutter/material.dart';

class CardPendingStatus extends StatelessWidget {
   CardPendingStatus({Key? key, this.color, this.text}) : super(key: key);

  String? text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Text(text ?? 'En attente', style: TextStyle(color: Colors.white, fontSize: 12),),
      ),
    );
  }
}
