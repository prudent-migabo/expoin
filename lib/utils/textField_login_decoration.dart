import 'package:flutter/material.dart';

  InputDecoration textFieldLoginDecoration ({
    Icon? prefixIcon,
    Icon? suffixIcon,
    String? hintText,
    Color? fillColor,
    bool? filled,
  }){
    return InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 14),
      fillColor: fillColor,
      filled: filled,
    );
}
