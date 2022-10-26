import 'dart:async';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/screens/verifyEmail_screen/components/components.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../utils/utils.dart';

class VerifyEmailScreen extends StatefulWidget {
   VerifyEmailScreen({Key? key}) : super(key: key);
  static const String routeName = "/VerifyEmailScreen";

  static Route route (){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => VerifyEmailScreen(),
    );
  }

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  User? user = FirebaseAuth.instance.currentUser;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Future(() async{
      setState(() {
        isEmailVerified = user!.emailVerified;
      });
      if(!isEmailVerified){
         sendEmailVerification();
      }

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
     await user!.reload();
     // setState(() {
     //   user;
     // });
    var u = FirebaseAuth.instance.currentUser!;
    setState(() {
      isEmailVerified = u.emailVerified;
    });
    if(isEmailVerified) timer!.cancel();
  }

  Future sendEmailVerification () async{
    try{
      await user!.sendEmailVerification();
    } catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeScreen()
      : Scaffold(
  body: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150,),
          Icon(Icons.mail_rounded, size: 100,),
          SizedBox(height: 10,),
          Text("Vérification de l'email", textAlign: TextAlign.center, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("Un mail de verification a été envoyé, veuillez verifier dans votre boite mail", textAlign: TextAlign.center,),
          SizedBox(height: 30,),
          Row(
            children: [
              Text("Je n'ai pas reçu l'email"),
              SizedBox(width: 5,),
              GestureDetector(
                  onTap: () {
                    sendEmailVerification();
                  },
                  child: Text("Renvoyer", style: TextStyle(color: kMainColor),)),
            ],
          ),
          SizedBox(height: 20,),
          CustomButton(
            text: "Annuler la vérification",
            onPressed: () async{
              await context.read<AuthRepository>().signOutUSer();
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
    ),
  ),
);
}


