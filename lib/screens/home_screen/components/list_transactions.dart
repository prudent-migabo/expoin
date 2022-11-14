import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ListTransactions extends StatelessWidget {
  ListTransactions({Key? key, required this.initialMoneyType, required this.finalMoneyType, required this.amount}) : super(key: key);
  String initialMoneyType;
  String finalMoneyType;
  String amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(Assets.btc),
      ),
      title: Text(initialMoneyType, style: fontSizeTile,),
      subtitle: Text(finalMoneyType, style: fontSizeTile,),
      trailing: Column(
        children: [
          Text("$amount\$", style: fontSizeTile,),
          Text("10.7%", style: fontSizeTile.copyWith(color: Colors.green),),
        ],
      ),
    );
  }
}
