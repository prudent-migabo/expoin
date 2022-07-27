import 'package:expoin/utils/constant.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailComponents extends StatelessWidget {
  const VerifyEmailComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Icon(Icons.mail_rounded, size: 100,),
            SizedBox(height: 10,),
            Text("Vérification de l'email", textAlign: TextAlign.center, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
            Text("Un mail de verification a été envoyé à :", textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Text("{context.read<User?>()!.email}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            Row(
              children: [
                Text("Je n'ai pas reçu l'email"),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: () async{
                    await context.read<User?>()!.sendEmailVerification();
                  },
                    child: Text("Renvoyer", style: TextStyle(color: kMainColor),)),
              ],
            ),
            SizedBox(height: 20,),
            CustomButton(
              text: "Annuler la vérification",
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
