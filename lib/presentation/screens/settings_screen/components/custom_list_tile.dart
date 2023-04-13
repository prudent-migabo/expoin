import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';

class CustomListTile extends StatelessWidget {
   CustomListTile({
    super.key,
    required this.subject,
    this.onTap,
  });

  final String subject;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(subject, style: GoogleFonts.dmSans(fontWeight: bold, fontSize: 15, color: Colors.black54),),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 13,),
    );
  }
}
