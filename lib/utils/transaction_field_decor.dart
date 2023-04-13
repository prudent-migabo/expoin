import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration transactionFieldDecor ({String? hintText}){
  return InputDecoration(
    hintText: hintText,
    hintStyle: GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[500]),
  );
}