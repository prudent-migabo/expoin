import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/utils.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);
  static const String routeName = "/BottomNavigationScreen";

  static Route route (){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BottomNavigationScreen(),
    );
  }

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    TransactionScreen(),
    CalculatorScreen(),
    HistoricScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
         //   backgroundColor: kMainColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 10,
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          iconSize: 25,
          selectedIconTheme: IconThemeData(color: kMainColor),
          selectedItemColor: kMainColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.rightLeft),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined),
              label: 'Calculatrice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historique',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// class BottomNavigationScreen extends StatefulWidget {
//   BottomNavigationScreen({Key? key}) : super(key: key);
//   static const String routeName = "/BottomNavigationScreen";
//   static Route route (){
//     return MaterialPageRoute(
//       settings: RouteSettings(name: routeName),
//         builder: (context)=> BottomNavigationScreen());
//   }
//
//   @override
//   State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
// }
//
// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//   int currentIndex = 1;
//   final screens = <Widget>[
//     TransactionScreen(),
//     HomeScreen(),
//     CalculatorScreen(),
//     HistoryScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBarTheme(
//         data: NavigationBarThemeData(
//         //  backgroundColor: Colors.grey,
//           indicatorColor: Colors.white,
//           labelTextStyle: MaterialStateProperty.all(
//             TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//           ),
//         ),
//         child: NavigationBar(
//           height: 60,
//           backgroundColor: kMainColor,
//           selectedIndex: currentIndex,
//           animationDuration: Duration(seconds: 1),
//           onDestinationSelected: (index){
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           destinations: [
//             NavigationDestination(
//                 icon: Icon(Icons.airline_stops_sharp,),
//                 label: "Transactions"
//             ),
//             NavigationDestination(
//                 icon: Icon(Icons.home),
//                 label: "Acceuil"
//             ),
//             NavigationDestination(
//                 icon: Icon(Icons.calculate_outlined),
//                 label: "Calculatrice",
//             ),
//             NavigationDestination(
//                 icon: Icon(Icons.history),
//                 label: "Historique"
//             ),
//           ],
//         ),
//       ),
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//     );
//   }
// }
