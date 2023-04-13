import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';

class RowInfos extends StatelessWidget {
  RowInfos({
    super.key,required this.title, required this.value,
  });

  String title;
  String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text('$title :')),
        Expanded(
            child: Text(value, style: TextStyle(fontWeight: bold), textAlign: TextAlign.start,)),
      ],
    );
  }
}