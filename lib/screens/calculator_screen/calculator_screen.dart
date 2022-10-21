import 'package:expoin/screens/calculator_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            leading: Container(),
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
                  text: 'CashIn',
                ),
                Tab(
                  text: 'Cashout',
                ),
                Tab(
                  text: 'Change',
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
