import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
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
        child: Image(image: AssetImage(Assets.expoinLogo), width: 300, height: 300,),
      ),
      nextScreen: Wrapper(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 3000,
      backgroundColor: Colors.white,
    );
  }
}
