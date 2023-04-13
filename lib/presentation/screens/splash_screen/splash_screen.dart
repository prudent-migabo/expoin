import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName ='/SplashScreen';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image(image: AssetImage(Assets.mesPiecesLogo)),
      ),
      nextScreen: Wrapper(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 3000,
      backgroundColor: Colors.white,
    );
  }
}
