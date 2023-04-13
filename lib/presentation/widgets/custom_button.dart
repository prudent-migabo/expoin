import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Custom button for all normal buttons
class CustomButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
      ),
    );
  }
}

class CustomSignUpButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  CustomSignUpButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.5,
          backgroundColor: Colors.white,
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: primary, width: 0.5),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
      ),
    );
  }
}

///Custom button for special buttons with a border color and the white background color
class BlankButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color? textColor;
  Color? borderColor;
  BlankButton({Key? key, required this.text, required this.onPressed, this.textColor, this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.5,
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: textColor!, width: 0.5),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
      ),
    );
  }
}