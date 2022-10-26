import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
   HomeMenu({Key? key, required this.color, required this.icon, required this.text, required this.onPressed}) : super(key: key);

  Color color;
  Widget icon;
  String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 15, right: 20),
        // width: 80,
        // height: 40,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 5,),
            Text(text),
          ],
        ),
      ),
    );
  }
}
