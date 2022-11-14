import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class RowForDetailsStyle extends StatelessWidget {

  RowForDetailsStyle({
    required this.title,
    required this.value,
  });
  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${title} :", style: TextStyle(fontSize: 15),),
        Text(' ${value}', style: kFontStyleDetailsTrans,),
      ],
    );
  }


}