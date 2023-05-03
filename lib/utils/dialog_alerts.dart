import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/utils/utils.dart';

/// Method that throws an error dialog box for the entire app
void errorDialog(BuildContext context, {required String? content, VoidCallback? onOkAction, bool? barrierDismissible, Widget? child }) {
  final errorColor = Theme.of(context).colorScheme.error;
  Widget okButton() {
    return TextButton(onPressed: () => onOkAction ?? Navigator.pop(context), child: child ?? Text(
      'OK',
      style: GoogleFonts.dmSans(fontWeight: bold, color: errorColor),
    ),);
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
      barrierDismissible: barrierDismissible ?? false, context: context, builder: (context) => alert);
}

//// Method that throws a normal alert dialog for information purpose
void alert(BuildContext context, {required String? content, required String title, VoidCallback? onPressed, Color? titleColor, Color? actionBtnColor}) {
  final primary = Theme.of(context).colorScheme.primary;
  Widget okButton() {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          'OK',
          style: TextStyle(
              fontWeight: bold, color: actionBtnColor ?? primary),
        ));
  }

  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: GoogleFonts.dmSans(color: titleColor ?? primary, fontWeight: bold),
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
//// This is the dialog box that styles every normal warning over the entire app but it also allows the user to interact by allowing or denying
void suppressDialog(BuildContext context,
    {required String? content,
      required String title,
      VoidCallback? onPressed,
      Color? titleColor,
      Color? actionButtonsColor}) {
  final primary = Theme.of(context).colorScheme.primary;
  Widget okButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Annuler',
              style: GoogleFonts.dmSans(
                  fontWeight: bold, color: actionButtonsColor ?? primary),
            )),
        TextButton(
            onPressed: onPressed,
            child: Text(
              'OK',
              style: GoogleFonts.dmSans(
                  fontWeight: bold, color: actionButtonsColor ?? primary),
            )),
      ],
    );
  }

  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: GoogleFonts.dmSans(color: titleColor ?? primary, fontWeight: bold),
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

checkingToast({String? message, Color? backgroundColor, Color? textColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.red[700],
    ),
    child: Text(
      "$message",
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 14,
        ),
      ),
    ),
  );
}


