import 'dart:async';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/screens/verifyEmail_screen/components/components.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  User? user;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await context.read<User?>()!.sendEmailVerification();
    });
    timer = Timer.periodic(Duration(seconds: 3), (timer) async{
     await checkEmailVerified();
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async{
    await context.read<User?>()!.reload();
    if (context.read<User?>()!.emailVerified) {
      timer!.cancel();
      Navigator.pushNamedAndRemoveUntil(context, BottomNavigationScreen.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text("Un mail de verification a été envoyé à :", textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Text("${context.read<User?>()!.email}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
    );
  }
}
