import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/utils/utils.dart';

/// Method that throws an error dialog box for the entire app
void errorDialog(BuildContext context, {required String? content}) {
  final errorColor = Theme.of(context).colorScheme.error;
  Widget okButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: errorColor),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'OK',
        style: GoogleFonts.dmSans(fontWeight: bold),
      ),
    );
  }


  AlertDialog alert = AlertDialog(
    title: Text(
      'Erreur',
      style: GoogleFonts.dmSans(color: errorColor, fontWeight: bold),
    ),
    content: Text(
      content!,
      style: GoogleFonts.dmSans(),
    ),
    actions: [
      okButton(),
    ],
  );

  showDialog(
      barrierDismissible: false, context: context, builder: (context) => alert);
}

//// Method that throws a normal alert dialog for information purpose
void alert(BuildContext context, {required String? content, required String title, VoidCallback? onPressed}) {
  Widget okButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600],),
      onPressed: onPressed,
      child: Text(
        'OK',
        style: GoogleFonts.dmSans(fontWeight: bold),
      ),
    );
  }

  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: GoogleFonts.dmSans(color: Colors.green[600], fontWeight: bold),
    ),
    content: Text(
      content!,
      style: GoogleFonts.dmSans(),
    ),
    actions: [
      okButton(),
    ],
  );

  showDialog(
      barrierDismissible: false, context: context, builder: (context) => alert);
}

//// Method that throws a normal alert dialog for information purpose but with 2 buttons
void suppressDialog(BuildContext context, {required String? content, required String title, VoidCallback? onPressed}) {
  final primary = Theme.of(context).colorScheme.primary;
  Widget okButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: (){
          Navigator.pop(context);
        }, child: Text(
          'Annuler',
          style: GoogleFonts.dmSans(fontWeight: bold),
        )),
        TextButton(
            onPressed: onPressed,
            child: Text(
          'OK',
          style: GoogleFonts.dmSans(fontWeight: bold),
        )),
      ],
    );
  }

  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: GoogleFonts.dmSans(color: primary, fontWeight: bold),
    ),
    content: Text(
      content!,
      style: GoogleFonts.dmSans(),
    ),
    actions: [
      okButton(),
    ],
  );

  showDialog(
      barrierDismissible: true, context: context, builder: (context) => alert);
}


void successToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green[600],
      textColor: Colors.white,
      gravity: ToastGravity.TOP);
}

void noNetworkToast(BuildContext context) {
  Fluttertoast.showToast(
    msg: noNetworkMessage,
    backgroundColor: Theme.of(context).colorScheme.error,
    textColor: Colors.white,
    gravity: ToastGravity.SNACKBAR,

  );
}


