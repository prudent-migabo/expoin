import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
   AuthHeader({Key? key, required this.text}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Text(
      text,
      style: TextStyle(
          color: primary,
          fontSize: 23,
          fontWeight: FontWeight.bold),
    );
  }
}

class AuthHeaderWithArrow extends StatelessWidget {
   AuthHeaderWithArrow({Key? key, required this.text}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Icon(Icons.arrow_back_rounded),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                color: primary,
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}


// InkWell(
//   child: Icon(Icons.arrow_back_rounded,),
//   onTap: (){
//     Navigator.pop(context);
//   },
// ),