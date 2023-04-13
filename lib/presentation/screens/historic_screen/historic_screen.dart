import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/screens/historic_screen/components/components.dart';

class HistoricScreen extends StatefulWidget {
  static const String routeName = '/HistoricScreen';

  HistoricScreen({Key? key}) : super(key: key);

  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: mainPadding.copyWith(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            TabBarFilter(
              index: index,
              onCashIn: () {
                setState(() {
                  index = 0;
                });
              },
              onCashOut: () {
                setState(() {
                  index = 1;
                });
              },
              onChange: () {
                setState(() {
                  index = 2;
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: index == 0
                    ? CashInHistoric()
                    : index == 1
                        ? CashOutHistoric()
                        : index == 2
                            ? ChangeHistoric()
                            : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
