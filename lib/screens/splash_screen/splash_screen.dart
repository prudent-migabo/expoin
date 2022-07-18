import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName='/SplashScreen';

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> SplashScreen());
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Text("Expoin", style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
      nextScreen: LoginScreen(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 3000,
      backgroundColor: Colors.black,
    );
  }
}
