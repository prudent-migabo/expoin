import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String routeName = '/EmailVerificationScreen';
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MesPiecesBloc? _bloc;
  Timer? timer;
  @override
  void initState() {
    _bloc = MesPiecesBloc();
    _init();
    super.initState();
  }

  _init (){
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      _bloc!.add(
        InitialVerificationEvent(),
      );
    });
  }

  _sendEmailMethod (){
    _bloc!.add(SendEmailVerificationEvent());
  }

  _logout (){
    _bloc!.add(SignOutEvent());
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
  listener: (context, state) {
        if (state is IsEmailVerified){
          Navigator.pushNamedAndRemoveUntil(context, AccountConfigurationScreen.routeName, (route) => false);
          timer!.cancel();
        } else if (state is EmailSent) {
          successToast(message: 'Requête de vérification email envoyée');
        } else if (state is UserLoggedOut){
          successToast(message: 'Deconnecté avec succès');
          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
        }  else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
  },
  child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            AuthHeader(text: 'Vérifiez votre mail pour continuer sur MesPièces',),
            SizedBox(height: 25,),
            Text('Nous avons envoyé un email à votre adresse ${_auth.currentUser!.email ?? '@gmail.com'}. Veuillez suivre les instructions pour confirmer votre mail', style: TextStyle(fontSize: 15),),
            SizedBox(height: 20,),
            Text("Si vous n'avez pas reçu l'email, veuillez cliquer le botton ci-dessous", style: TextStyle(fontSize: 15),),
            SizedBox(height: 35,),
            CustomButton(text: "Renvoyer l'email", onPressed: _sendEmailMethod),
            SizedBox(height: 10,),
            BlankButton(
              borderColor: primary,
                textColor: primary,
                text: "Se déconnecter", onPressed: _logout),
          ],
        ),
      ),
    ),
);
  }
}
