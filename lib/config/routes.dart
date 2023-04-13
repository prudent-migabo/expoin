import 'package:flutter/material.dart';
import 'package:expoin/presentation/presentation.dart';

class RoutesGenerator {
  static Route<dynamic> onGeneratedRoutes (RouteSettings settings){
    print(settings.name);
    switch (settings.name) {
      case SplashScreen.routeName :
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case BottomNavigationScreen.routeName :
        return MaterialPageRoute(builder: (context) => BottomNavigationScreen());
      case LoginScreen.routeName :
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case ForgotPasswordScreen.routeName :
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      case DashBoardScreen.routeName :
        return MaterialPageRoute(builder: (context) => DashBoardScreen());
      case DashBoardDetailsScreen.routeName :
        return MaterialPageRoute(builder: (context) => DashBoardDetailsScreen());
      case DashBoardCryptoDetailsScreen.routeName :
        return MaterialPageRoute(builder: (context) => DashBoardCryptoDetailsScreen());
      case RegisterScreen.routeName :
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case PinScreen.routeName :
        return MaterialPageRoute(builder: (context) => PinScreen());
      case EmailVerificationScreen.routeName :
        return MaterialPageRoute(builder: (context) => EmailVerificationScreen());
      case AccountConfigurationScreen.routeName :
        return MaterialPageRoute(builder: (context) => AccountConfigurationScreen());
      case RegisterCryptoScreen.routeName :
        return MaterialPageRoute(builder: (context) => RegisterCryptoScreen());
      case TransactionScreen.routeName :
        return MaterialPageRoute(builder: (context) => TransactionScreen());
      case PinVerificationScreen.routeName :
        return MaterialPageRoute(builder: (context) => PinVerificationScreen());
      case SettingsScreen.routeName :
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case ChangePasswordScreen.routeName :
        return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
      case HistoricScreen.routeName :
        return MaterialPageRoute(builder: (context) => HistoricScreen());
      case UpdatePhoneScreen.routeName :
        return MaterialPageRoute(builder: (context) => UpdatePhoneScreen());
      case UpdatePinCodeScreen.routeName :
        return MaterialPageRoute(builder: (context) => UpdatePinCodeScreen());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute (){
    return MaterialPageRoute(builder: (context){
      return const Scaffold(
        body: Center(
          child: Text('Page non trouvée'),
        ),
      );
    }
    );
  }
}