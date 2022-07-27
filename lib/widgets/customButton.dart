import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  CustomButton({Key? key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text!),
      ),
    );
  }
}
