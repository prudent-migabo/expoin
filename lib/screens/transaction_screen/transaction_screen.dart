import 'package:expoin/screens/transaction_screen/components/components.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);
  static const String routeName = "/TransactionScreen";

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> TransactionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return TransactionComponents();
  }
}
