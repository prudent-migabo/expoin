import 'dart:io';
import 'package:expoin/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alertDialog(BuildContext context, {String? title, String? content, VoidCallback? onPressed}){
  if(Platform.isIOS){
    showCupertinoDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!),
            actions: [
              CupertinoDialogAction(
                  onPressed:(){
                    Navigator.pop(context);
                  }
                  ,child: Text('Annuler')),
              CupertinoDialogAction(
                  onPressed: onPressed,
                  child: Text('Oui')),
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
            title: Text(title!),
            content: Text(content!),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.pop(context);
                  }
                  ,child: Text('Annuler')),
              TextButton(
                  onPressed:onPressed,
                  child: Text('Oui')),
            ],
          );
        }
    );
  }
}