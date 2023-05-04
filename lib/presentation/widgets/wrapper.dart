import 'package:expoin/business_logic/bloc/mes_pieces_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expoin/data/repositories/information_repository.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  InformationRepository repository = InformationRepository();
  final MesPiecesBloc _bloc = MesPiecesBloc();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            return LoaderEmailChecker();
          } else if (snapshot.connectionState == ConnectionState.waiting){
            return IsLoading();
          } else {
            return LoginScreen();
          }
        });
  }
}

 class Wrapper2 extends StatelessWidget {
    Wrapper2({Key? key}) : super(key: key);

   final MesPiecesBloc _bloc = MesPiecesBloc();

   @override
   Widget build(BuildContext context) {
     return BlocListener(
       bloc: _bloc,
       listener: (context, state){

       },
       child: PinVerificationScreen(),
     );
   }
 }
