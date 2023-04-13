
import 'package:flutter/material.dart';

InputDecoration textFieldAuthDecoration ({
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? hintText,
  Color? fillColor,
  bool? filled,
  String? labelText,
}){
  return InputDecoration(
    suffixIcon: suffixIcon,
   prefixIcon: prefixIcon,
   hintText: hintText,
   // contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
  );
}
