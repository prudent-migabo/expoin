import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGeneratedRoute(RouteSettings settings){
    print(settings.name);
    switch(settings.name){
      case SplashScreen.routeName :
        return SplashScreen.route();
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