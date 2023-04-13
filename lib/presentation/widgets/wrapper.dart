import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expoin/data/repositories/information_repository.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/presentation/presentation.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  InformationRepository repository = InformationRepository();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            return PinVerificationScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          } else {
            return LoginScreen();
          }
        });
  }
}
