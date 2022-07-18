import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterComponents extends StatelessWidget {
  RegisterComponents({
    Key? key,
  }) : super(key: key);

  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/expoin logo.jpg",
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: width,
        height: height,
        color: Colors.black.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Text("Expoin", style: TextStyle(color: Colors.white, fontSize: 30),),
            SizedBox(height: 30,),
            Text("S'inscrire", style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height: 17,),
            Text("Créer votre compte de d'utilisation...", style: TextStyle(color: Colors.white, fontSize: 13),),
            SizedBox(height: 30,),
            TextFormField(
              decoration: textFieldLoginDecoration(prefixIcon: Icon(Icons.mail_rounded, color: Color(0xff004d99), size: 20,), hintText: "expoin@gmail.com"),
              onChanged: (val){},
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: textFieldLoginDecoration(prefixIcon: Icon(Icons.vpn_key_rounded,color: Color(0xff004d99), size: 20,), suffixIcon: Icon(Icons.remove_red_eye_rounded, color: Color(0xff004d99), size: 20,), hintText: "1abxc@por"),
              onChanged: (val){},
            ),
            SizedBox(height: 30,),
            CustomButton(
              height: 50,
              text: "S'INSCRIRE",
              onPressed: (){},
            ),
            SizedBox(height: 40,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Avez-vous déjà un compte?", style: TextStyle(color: Colors.white),),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text("Se connecter", style: TextStyle(color: Colors.lightBlue),),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
