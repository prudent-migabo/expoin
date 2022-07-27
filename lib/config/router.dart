import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings){
    print(settings.name);
    switch(settings.name){
      case SplashScreen.routeName :
        return SplashScreen.route();
      case LoginScreen.routeName :
        return LoginScreen.route();
      case RegisterScreen.routeName :
        return RegisterScreen.route();
      case ForgotPasswordScreen.routeName :
        return ForgotPasswordScreen.route();
      case VerifyEmailScreen.routeName :
        return VerifyEmailScreen.route();
      case BottomNavigationScreen.routeName :
        return BottomNavigationScreen.route();
      case Validation1Screen.routeName :
        return Validation1Screen.route();
      case Validation2Screen.routeName :
        return Validation2Screen.route();
      case Validation3Screen.routeName :
        return Validation3Screen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute(){
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (context){
          return Scaffold();
        });

  }
}