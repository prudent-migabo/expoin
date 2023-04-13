import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, size: 20,)),
          SizedBox(width: 10,),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: bold),),
        ],
      ),
    );
  }
}
