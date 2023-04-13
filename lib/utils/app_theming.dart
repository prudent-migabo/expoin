import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme= ThemeData(
  //Color(0xfffcae01),
  scaffoldBackgroundColor: Color(0xfff7f7f7),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.dmSans(
      textStyle: TextStyle(
        color: Colors.black.withOpacity(.7),
        fontFamily: 'DM sans',
      ),
    ),
    bodyMedium: GoogleFonts.dmSans(
      textStyle: TextStyle(
        color: Colors.black.withOpacity(.7),
        fontFamily: 'DM sans',
      ),
    ),
    bodySmall: GoogleFonts.dmSans(),
    displayLarge: GoogleFonts.dmSans(),
    displayMedium: GoogleFonts.dmSans(),
    titleMedium: GoogleFonts.dmSans(),
    headlineLarge: GoogleFonts.dmSans(),
    headlineSmall: GoogleFonts.dmSans(),
    titleLarge: GoogleFonts.dmSans(),
    titleSmall: GoogleFonts.dmSans(),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Color(0xff004d99),
    secondary: Color(0xff004d99),
    brightness: Brightness.light,
    error: Colors.red[600],
  ) ,
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Color(0xff004d99),
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Color(0xff004d99),
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
    labelStyle: TextStyle(color: Colors.black,
        fontSize: 13.0),
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
    hintStyle: TextStyle(color: Colors.black26),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
    ),
  ),
);