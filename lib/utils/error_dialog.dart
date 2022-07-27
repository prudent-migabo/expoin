import 'dart:io';
import 'package:expoin/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, CustomError e){
  if(Platform.isIOS){
    showCupertinoDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text(e.code),
            content: Text(e.plugin+'\n'+e.message),
            actions: [
              CupertinoDialogAction(
                  onPressed:(){
                    Navigator.pop(context);
                  }
                  ,child: Text('ok')),
            ],
          );
        }
    );
  }

  else{
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(e.code),
            content: Text(e.plugin+'\n'+e.message),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.pop(context);
                  }
                  ,child: Text('ok')),

            ],
          );
        }
    );
  }
}