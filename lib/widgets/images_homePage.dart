import 'package:flutter/material.dart';

class ImagesHomePage extends StatelessWidget {
   ImagesHomePage({Key? key, required this.image}) : super(key: key);
  ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image(image: image, fit: BoxFit.cover),
    );
  }
}
