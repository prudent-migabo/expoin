import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/config/routes.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/firebase_options.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (context)=> AuthRepository()),
        Provider<CashOutRepository>(create: (context)=> CashOutRepository()),
        ChangeNotifierProvider<CashOutProvider>(create: (context)=> CashOutProvider(cashOutRepository: context.read<CashOutRepository>()),),
        Provider<CashInRepository>(create: (context)=> CashInRepository()),
        ChangeNotifierProvider<CashInProvider>(create: (context)=> CashInProvider(cashInRepository: context.read<CashInRepository>()),),
        Provider<ChangeRepository>(create: (context)=> ChangeRepository()),
        StreamProvider<UserModel>(create: (context) => context.read<AuthRepository>().getUserInformation(),
          initialData: UserModel.initial(),
        ),
        ChangeNotifierProvider<CashInCalculationProvider>(create: (context) => CashInCalculationProvider()),
        ChangeNotifierProvider<SaveCashInDetailsController>(create: (context) => SaveCashInDetailsController()),
        ChangeNotifierProvider<SaveCashOutDetailsController>(create: (context)=> SaveCashOutDetailsController()),
        ChangeNotifierProvider<SaveChangeDetailsController>(create: (context) => SaveChangeDetailsController()),
        Provider<ImagesRepository>(create: (context)=> ImagesRepository()),
        StreamProvider<CashInRateModel>(create: (context)=> RatesRepository().getCashIn(),
            initialData: CashInRateModel.initial(),
        ),
        // StreamProvider<List<CashInModel>>(create: (context)=> CashInRepository().getListCashInOrdered(),
        //   initialData:  [],
        // ),
        // StreamProvider<CashInRateModel>(create: (context)=> RatesRepository().getCashIn(),
        //   initialData: CashInRateModel.initial(),
        // ),
        // StreamProvider<CashInRateModel>(create: (context)=> RatesRepository().getCashIn(),
        //   initialData: CashInRateModel.initial(),
        // ),
        StreamProvider<CashOutRateModel>(create: (context)=> RatesRepository().getCashOut(), initialData: CashOutRateModel.initial()),
        StreamProvider<ChangeRateModel>(create: (context)=> RatesRepository().getChange(), initialData: ChangeRateModel.initial()),
        ChangeNotifierProvider<CashOutCalculationProvider>(create: (context)=> CashOutCalculationProvider()),
        ChangeNotifierProvider<ChangeCalculationProvider>(create: (context)=> ChangeCalculationProvider()),
        ChangeNotifierProvider<ChangeProvider>(create: (context)=>ChangeProvider(changeRepository: context.read<ChangeRepository>())),
        Provider<HashNumberRepository>(create: (context)=> HashNumberRepository()),
        Provider<PhoneNumbersRepository>(create: (context)=> PhoneNumbersRepository()),
        Provider<MobileRepository>(create: (context)=> MobileRepository()),
        ChangeNotifierProvider<HashNumberProvider>(create: (context)=> HashNumberProvider()),
        ChangeNotifierProvider<TotalAmountProvider>(create: (context)=> TotalAmountProvider()),
      ],
      child: MaterialApp(
        onGenerateRoute: RoutesGenerator.onGeneratedRoutes,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        theme: lightTheme,
      ),
    );
  }
}
