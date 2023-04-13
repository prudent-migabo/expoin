import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';

class ContainerForCalculator extends StatelessWidget {
   ContainerForCalculator({Key? key, this.content, this.title}) : super(key: key);
   String? content;
   String? title;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding( padding: padding1, child: Text(title!, style: style1),),
        Container(
          padding: const EdgeInsets.only(top: 12, left: 10),
          width: width,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(content ?? ""),
        ),
      ],
    );
  }
}
