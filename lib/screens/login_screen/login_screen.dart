import 'package:expoin/providers/auth_provider/auth_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/login_screen/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/WelcomeScreen";

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    var userState = context.watch<AuthProvider>().state;
    if(userState.authStatus == AuthStatus.authenticated){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(context, BottomNavigationScreen.routeName, (route) => false);
      });
    }
    return Scaffold(
      body: LoginComponents(),
    );
  }
}
