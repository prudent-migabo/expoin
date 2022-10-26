import 'package:expoin/screens/historic_screen/components/components.dart';
import 'package:flutter/material.dart';

class HistoricScreen extends StatelessWidget {
  const HistoricScreen({Key? key}) : super(key: key);
  static const String routeName = "/HistoricScreen";

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> HistoricScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HistoricComponents(),
    );
  }
}
