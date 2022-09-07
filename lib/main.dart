import 'package:expoin/config/router.dart';
import 'package:expoin/firebase_options.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (context)=> AuthRepository(auth: FirebaseAuth.instance)),
        StreamProvider<User?>(
            create: (context) => context.read<AuthRepository>().userState,
            initialData: null),
        ChangeNotifierProxyProvider<User?, AuthProvider>(create: (context) => AuthProvider(), update: (BuildContext context, User? user, AuthProvider? authProvider) => authProvider!..update(user),),
        ChangeNotifierProvider<LoginProvider>(create: (context)=> LoginProvider(authRepository: context.read<AuthRepository>()),),
        ChangeNotifierProvider<RegisterProvider>(create: (context)=> RegisterProvider(authRepository: context.read<AuthRepository>()),),
        Provider<ForgotPasswordRepository>(create: (context)=> ForgotPasswordRepository(auth: FirebaseAuth.instance),),
        ChangeNotifierProvider<ForgotPasswordProvider>(create: (context)=> ForgotPasswordProvider(forgotPasswordRepository: context.read<ForgotPasswordRepository>()),),
        Provider<CryptoToMobileRepository>(create: (context)=> CryptoToMobileRepository(auth: FirebaseAuth.instance)),
        ChangeNotifierProvider<CryptoToMobileProvider>(create: (context)=> CryptoToMobileProvider(cryptoToMobileRepository: context.read<CryptoToMobileRepository>()),),
        Provider<MobileToCryptoRepository>(create: (context)=> MobileToCryptoRepository(auth: FirebaseAuth.instance)),
        ChangeNotifierProvider<MobileToCryptoProvider>(create: (context)=> MobileToCryptoProvider(mobileToCryptoRepository: context.read<MobileToCryptoRepository>()),),
        Provider<CryptoToCryptoRepository>(create: (context)=> CryptoToCryptoRepository(auth: FirebaseAuth.instance)),
        ChangeNotifierProvider<CryptoToCryptoProvider>(create: (context)=> CryptoToCryptoProvider(cryptoToCryptoRepository: context.read<CryptoToCryptoRepository>()),),
        Provider<CashOutRepository>(create: (context)=> CashOutRepository()),
        ChangeNotifierProvider<CashOutProvider>(create: (context)=> CashOutProvider(cashOutRepository: context.read<CashOutRepository>()),),
        Provider<RateRepository>(create: (context)=> RateRepository()),
        ChangeNotifierProvider<RetreiveCashOutDetails>(create: (context)=> RetreiveCashOutDetails(cashOutRepository: context.read<CashOutRepository>(), rateRepository: context.read<RateRepository>())),
        ChangeNotifierProvider<RateProvider>(create: (context)=> RateProvider(rateRepository: context.read<RateRepository>())),
        StreamProvider<RateModel>(create: (context) {
          print("======================main ${context.read<RateRepository>().getRateValueDetail()} =====================");
          return context.read<RateRepository>().getRateValueDetail();
    }, initialData: RateModel(rate: "")),
        // StreamProvider<RateModel>(create: (context) => context.read<RateRepository>().getRateValueDetail("BNB"), initialData: RateModel(rate: "")),
        StreamProvider<CashOutModel>(create: (context) => context.read<CashOutRepository>().getCashOutDetail(context.read<User>().uid), initialData: CashOutModel(cryptoAmount: '', mobileType: '', cryptoType: '')),
        ChangeNotifierProvider<CashOutCalculationResult>(create: (context)=>CashOutCalculationResult()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
