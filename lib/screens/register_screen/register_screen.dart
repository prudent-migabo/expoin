import 'package:expoin/providers/providers.dart';
import 'package:expoin/providers/register_provider/register_state.dart';
import 'package:expoin/screens/login_screen/components/components.dart';
import 'package:expoin/screens/register_screen/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String routeName = "/RegisterScreen";

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width =  MediaQuery.of(context).size.width;
    var registerState = context.watch<RegisterProvider>().state;
    if(registerState.registerStatus == RegisterStatus.isLoaded){
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        // print("--------USER CREATED--------");
       // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmailScreen()));
         Navigator.pushNamed(context, VerifyEmailScreen.routeName);
      });
    }
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: RegisterComponents(),
          )),
    );
  }
}
