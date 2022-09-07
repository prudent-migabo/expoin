
import 'package:expoin/screens/forgotPassword_screen/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = "/ForgotPasswordScreen";
  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
        builder: (context)=>ForgotPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
        leading: Icon(Icons.arrow_back_outlined, size: 25, color: Colors.black,),
      ),
      body: ForgotPasswordComponents(),
    );
  }
}
