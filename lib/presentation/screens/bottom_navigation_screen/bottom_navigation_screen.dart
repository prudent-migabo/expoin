import 'package:flutter/material.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/presentation/screens/transaction_screen/transaction_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String routeName = '/BottomNavigationScreen';
  BottomNavigationScreen({Key? key}) : super(key: key);


  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  int _selectedIndex = 0;
  List<Widget> _pages = [
    DashBoardScreen(),
    HistoricScreen(),
    AccountScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 7,
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          iconSize: 30,
          selectedIconTheme: IconThemeData(color: primary),
          selectedItemColor: primary,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cached_rounded, size: 25),
              label: 'Historiques',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet, size: 25),
              label: 'Comptes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25),
              label: 'Paramètres',
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