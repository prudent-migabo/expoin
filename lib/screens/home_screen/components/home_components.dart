import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeComponents extends StatelessWidget {
  const HomeComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future logOut() async{
      await context.read<AuthRepository>().signOutUSer();
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    }
    return Container(
      child: Center(child: GestureDetector(
        onTap: (){
          logOut();
        },
          child: Text("BIENVENUE")),),
    );
  }
}
