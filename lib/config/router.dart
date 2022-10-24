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
      case CashOutValidationScreen.routeName :
        return CashOutValidationScreen.route();
      case CashInValidationScreen.routeName :
        return CashInValidationScreen.route();
      case ChangeValidationScreen.routeName :
        return ChangeValidationScreen.route();
      case TransactionScreen.routeName :
        return TransactionScreen.route();
      case CalculatorScreen.routeName :
        return CalculatorScreen.route();
      case HistoricScreen.routeName :
        return HistoricScreen.route();
      case HomeScreen.routeName :
        return HomeScreen.route();
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