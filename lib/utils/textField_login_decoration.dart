import 'package:flutter/material.dart';

  InputDecoration textFieldLoginDecoration ({
    IconData? prefixIcon,
    IconButton? suffixIcon,
    String? hintText,
    Color? fillColor,
    bool? filled,
    String? labelText,
  }){
    return InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Color(0xff004d99), size: 20,),
        suffixIcon: suffixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 14),
      hintStyle: TextStyle(fontSize: 13),
      fillColor: fillColor,
      filled: filled,
      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
}
