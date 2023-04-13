import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/utils/utils.dart';

class CardCryptoModel extends StatelessWidget {
   CardCryptoModel({Key? key, this.trailing, this.controller, this.title, this.image}) : super(key: key);


   Widget? trailing;
   TextEditingController? controller;
   String? title;
   String? image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading:  CircleAvatar(radius: 20, backgroundImage: AssetImage(image!)),
            title: Text(title!, style: GoogleFonts.dmSans(fontWeight: bold, fontSize: 14),),
            // trailing: trailing,
          ),
          Container(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: TextFormField(
                controller: controller,
                style: TextStyle(fontSize: 13, ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: 'Entrez votre wallet',
                ),
                validator: (value) => value!.isEmpty? 'Une value null ne peut être enregistrée' : null,
              )),
        ],
      ),
    );
  }
}
