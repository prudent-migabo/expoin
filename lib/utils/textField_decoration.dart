import 'package:flutter/material.dart';

InputDecoration textFieldDecoration ({String? hintText, }){
  return InputDecoration(
    hintText: hintText ?? "",
    hintStyle: TextStyle(fontSize: 12, color: Colors.black54),
  );
}