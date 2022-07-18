import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  double? height;
  CustomButton({Key? key, this.text, this.onPressed, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text!),
      ),
    );
  }
}
