import 'package:expoin/screens/cashOut_screen/transaction/crypto.dart';
import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({Key? key}) : super(key: key);
  static const String routeName = "/BottomNavigationScreen";
  static Route route (){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
        builder: (context)=> BottomNavigationScreen());
  }

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 1;
  final screens = <Widget>[
    TransactionScreen(),
    HomeScreen(),
    CalculatorScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
        //  backgroundColor: Colors.grey,
          indicatorColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: kMainColor,
          selectedIndex: currentIndex,
          animationDuration: Duration(seconds: 1),
          onDestinationSelected: (index){
            setState(() {
              currentIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.airline_stops_sharp,),
                label: "Transactions"
            ),
            NavigationDestination(
                icon: Icon(Icons.home),
                label: "Acceuil"
            ),
            NavigationDestination(
                icon: Icon(Icons.calculate_outlined),
                label: "Calculatrice",
            ),
            NavigationDestination(
                icon: Icon(Icons.history),
                label: "Historique"
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
