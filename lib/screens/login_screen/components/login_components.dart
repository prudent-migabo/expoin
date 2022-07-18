import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginComponents extends StatelessWidget {
  LoginComponents({
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
            Text("Se Connecter", style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height: 17,),
            Text("Connectez-vous pour gérer votre compte...", style: TextStyle(color: Colors.white, fontSize: 13),),
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
              text: "SE CONNECTER",
              onPressed: (){},
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 170),
              child: GestureDetector(
                onTap: (){},
                child: Text("Mot de passe oublié?", style: TextStyle(color: Colors.lightBlue, fontSize: 13),),
              ),
            ),
            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Vous n'avez pas encore de compte?", style: TextStyle(color: Colors.white, fontSize: 13),),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text("S'inscrire", style: TextStyle(color: Colors.lightBlue),),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Ou se connecter via:", style: TextStyle(color: Colors.white,fontSize: 13),),
                SizedBox(height: 15,),
                Image.asset("assets/images/google.png", height: 40, width: 40,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
