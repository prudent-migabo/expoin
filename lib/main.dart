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
        Provider<CashOutRepository>(create: (context)=> CashOutRepository(auth: FirebaseAuth.instance)),
        ChangeNotifierProvider<CashOutProvider>(create: (context)=> CashOutProvider(cashOutRepository: context.read<CashOutRepository>()),),
        Provider<CashInRepository>(create: (context)=> CashInRepository(auth: FirebaseAuth.instance)),
        ChangeNotifierProvider<CashInProvider>(create: (context)=> CashInProvider(cashInRepository: context.read<CashInRepository>()),),
        Provider<ChangeRepository>(create: (context)=> ChangeRepository(auth: FirebaseAuth.instance)),
        StreamProvider<UserModel>(create: (context) => context.read<AuthRepository>().getUserName(),  initialData: UserModel.initial(),),
        ChangeNotifierProvider<CashInCalculationProvider>(create: (context) => CashInCalculationProvider()),
        ChangeNotifierProvider<SaveCashInDetailsController>(create: (context) => SaveCashInDetailsController()),
        ChangeNotifierProvider<SaveCashOutDetailsController>(create: (context)=> SaveCashOutDetailsController()),
        ChangeNotifierProvider<SaveChangeDetailsController>(create: (context) => SaveChangeDetailsController()),
        Provider<ImagesRepository>(create: (context)=> ImagesRepository()),
        StreamProvider<CashInRateModel>(create: (context)=> RatesRepository().getCashIn(), initialData: CashInRateModel.initial()),
        StreamProvider<CashOutRateModel>(create: (context)=> RatesRepository().getCashOut(), initialData: CashOutRateModel.initial()),
        StreamProvider<ChangeRateModel>(create: (context)=> RatesRepository().getChange(), initialData: ChangeRateModel.initial()),
        ChangeNotifierProvider<CashOutCalculationProvider>(create: (context)=> CashOutCalculationProvider()),
        ChangeNotifierProvider<ChangeCalculationProvider>(create: (context)=> ChangeCalculationProvider()),
        ChangeNotifierProvider<ChangeProvider>(create: (context)=>ChangeProvider(changeRepository: context.read<ChangeRepository>())),
        Provider<HashNumberRepository>(create: (context)=> HashNumberRepository()),
        Provider<PhoneNumbersRepository>(create: (context)=> PhoneNumbersRepository()),
        ChangeNotifierProvider<HashNumberProvider>(create: (context)=> HashNumberProvider()),
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
