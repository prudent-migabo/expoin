import 'package:expoin/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CashOutCalculationResult with ChangeNotifier{
  // double result = 0.0;

  cashOutCalculationResult(BuildContext context) {
    var rate =  Provider.of<RateModel>(context, listen: false).rate;
    var cryptoAmount = Provider.of<CashOutModel>(context, listen: false).cryptoAmount;
    print("================CashOutCalculationResult$rate ===============");
    print("================CashOutCalculationResult $cryptoAmount ===============");
   // var result = await double.parse(rate!) * double.parse(cryptoAmount!);
  //  print("================CashOutCalculationResult result:$result ===============");
  }

}