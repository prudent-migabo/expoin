import 'package:expoin/screens/calculator_screen/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);
  static const String routeName = "/CalculatorScreen";

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> CalculatorScreen());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            leading: Container(
              margin: EdgeInsets.only(top: 20),
              child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                  },
                  child: Icon(Icons.arrow_back_rounded)),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text("Calculatrice", style: headerTitle,),
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  text: 'ACHAT',
                ),
                Tab(
                  text: 'VENTE',
                ),
                Tab(
                  text: 'CHANGE',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
            children: [
          CashIn(),
          CashOut(),
          Change(),
        ]),
      ),
    );
  }
}
