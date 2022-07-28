import 'package:expoin/screens/crypto_to_mobile_screen/transaction/crypto.dart';
import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({Key? key}) : super(key: key);
  static const String routeName = "/BottomNavigationScreen";
  static Route route (){
    return MaterialPageRoute(builder: (context)=> BottomNavigationScreen());
  }

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 1;
  final screens = <Widget>[
    CryptoToMobileScreen(),
    MobileToCryptoScreen(),
    CryptoToCryptoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        backgroundColor: kMainColor,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: 28,
        //selectedFontSize: 15,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.airline_stops_sharp,),
              label: 'Transaction 1'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airline_stops_sharp,),
              label: 'Transaction 2'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airline_stops_sharp,),
              label: "Transaction 3"
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
