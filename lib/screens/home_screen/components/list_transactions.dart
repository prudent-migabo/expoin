import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ListTransactions extends StatelessWidget {
  ListTransactions({Key? key, this.initialMoneyType, this.finalMoneyType, this.amount}) : super(key: key);
  String? initialMoneyType;
  String? finalMoneyType;
  String? amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(btc),
      ),
      title: Text(initialMoneyType!, style: fontSizeTile,),
      subtitle: Text(finalMoneyType!, style: fontSizeTile,),
      trailing: Column(
        children: [
          Text("$amount\$", style: fontSizeTile,),
          Text("10.7%", style: fontSizeTile.copyWith(color: Colors.green),),
        ],
      ),
    );
    //   ListView.builder(
    //   itemCount: 10,
    //     itemBuilder: (context, index){
    //   return ListTile(
    //     leading: CircleAvatar(
    //       child: Image.asset(btc),
    //     ),
    //     title: Text("BTC"),
    //     subtitle: Text("Mobile"),
    //     trailing: Column(
    //       children: [
    //         Text("333 450\$"),
    //         Text("10.7%", style: TextStyle(color: Colors.green),),
    //       ],
    //     ),
    //   );
    // });
  }
}
