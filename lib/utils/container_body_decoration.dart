import 'package:flutter/material.dart';

BoxDecoration containerBodyDecoration({double? topLeftRadius, double? topRightRadius, Color? color}){
  return BoxDecoration(
    // border: Border.all(color: borderColor!),
    borderRadius: BorderRadius.only(topLeft: Radius.circular(topLeftRadius!), topRight: Radius.circular(topRightRadius!)),
    color: color!,
  );
}
