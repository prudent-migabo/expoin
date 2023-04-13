import 'package:flutter/material.dart';

class AuthLabel extends StatelessWidget {
  AuthLabel(this.text, {super.key});

  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 8),
      child: Text(text),
    );
  }
}
