import 'package:expoin/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashInCalculationProvider with ChangeNotifier{

  double result = 0.0;

  Future cashInCalculation ({
    required BuildContext context,
    String? value,
    String? rate1,
    String? rate2,
    String? rate3,
    String? rate4,
  }) async{
    double newValue = double.parse(value!);
    double newRate1 = double.parse(rate1!);
    double newRate2 = double.parse(rate2!);
    double newRate3 = double.parse(rate3!);
    double newRate4 = double.parse(rate4!);


    if(newValue >= 5 && newValue <=49) {
      var rate = (newValue * newRate1) /100;
      result = newValue + rate;
      notifyListeners();
    } else if (newValue >= 50 && newValue <=99){
      var rate = (newValue * newRate2) /100;
      result = newValue + rate;
      notifyListeners();
    } else if (newValue >= 100 && newValue <= 999) {
      var rate = (newValue * newRate3) / 100;
      result = newValue + rate;
      notifyListeners();
    } else if (newValue >= 1000) {
      var rate = (newValue * newRate4) / 100;
      result = newValue + rate;
      notifyListeners();
    } return;
  }


  void initializer (){
    result = 0.0;
    notifyListeners();
  }

}