import 'package:flutter/material.dart';

class CustomCardField extends StatelessWidget {
  CustomCardField({Key? key, required this.controller}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 40,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: "Saisissez le nom d'un compte",
            suffixIcon: Icon(Icons.search, size: 20,),
            contentPadding: EdgeInsets.only(top: 10, left: 15),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CustomCardFieldWithoutSuffix extends StatelessWidget {
  CustomCardFieldWithoutSuffix({Key? key, required this.controller}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 40,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: "Saisissez le nom d'un compte",
            contentPadding: EdgeInsets.only(top: 10, left: 15, bottom: 15),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
