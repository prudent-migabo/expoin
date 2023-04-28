import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperVerificationScreen extends StatefulWidget {
   WrapperVerificationScreen({Key? key}) : super(key: key);

  @override
  State<WrapperVerificationScreen> createState() => _WrapperVerificationScreenState();
}

class _WrapperVerificationScreenState extends State<WrapperVerificationScreen> {
   final MesPiecesBloc _bloc = MesPiecesBloc();

   _onLogout() {
     _bloc.add(SignOutEvent());
   }

   _logout(){
     AuthRepository().signOut();
     print('User logged out');
   }

   _onWrapperVerification(){
     _bloc.add(WrapperEvent());
   }

   @override
  void initState() {
     _onWrapperVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: ProfileRepository().getUserModel(),
      builder: (context, snapshot) {
        UserModel? userModel = snapshot.data;
       // print('user role is ${userModel!.role}');
        if (!snapshot.hasData){
          return LoginScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting){
          return IsLoading();
        } else if (snapshot.hasData && userModel!.role! != 'client'){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            errorDialog(context, content: "Vous n'avez pas de compte client chez MesPieces, veuillez en creer un svp.", onOkAction: (){
              Navigator.pop(context);
            });
          });
          _logout();
          print('00000000000000000000000000000000000000000000000000000000000000000000000000000000');

        } else if (snapshot.hasData && userModel!.isBlocked! == true){
          // errorDialog(context, content: "Désolé vous n'avez pas de compte actif chez MesPieces, il a été bloqué. Veuillez contacter l'administration.", onOkAction: (){
          //   _onLogout();
          // });
          print('1111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
        } else if (snapshot.hasData && userModel!.isDeleted! == true) {
          // errorDialog(context, content: "Désolé vous n'avez pas de compte actif chez MesPieces, il a été supprimé. Veuillez en creer un autre svp.", onOkAction: (){
          //   _onLogout();
          // });
          print('222222222222222222222222222222222222222222222222222222222222222222222222222222222222222');
        } else if (snapshot.hasError){
          print(snapshot.error.toString());
         // errorDialog(context, content: snapshot.error.toString());
        } else if (snapshot.hasData){
          return PinVerificationScreen();
        }
        return LoginScreen();
      }
    );
  }
}


