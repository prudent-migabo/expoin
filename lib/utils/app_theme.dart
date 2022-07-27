import 'package:flutter/material.dart';

ThemeData lightTheme= ThemeData(
  //Color(0xfffcae01),
  scaffoldBackgroundColor: Color(0xfff7f7f7),
  colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Color(0xff004d99),
      secondary: Color(0xff004d99),
      brightness: Brightness.light
  ) ,
  inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: Color(0xff004d99),
              width: 1.5,
              style: BorderStyle.solid,
          ),
      ),
      labelStyle: TextStyle(color: Colors.black,
          fontSize: 14.0),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
            color: Color(0xff004d99),
            width: 1.5,
            style: BorderStyle.solid
        ),
      ),
      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
      hintStyle: TextStyle(color: Colors.black26),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white,
    ),
  ),
);