import 'package:flutter/material.dart';

class CashOutCalculationProvider with ChangeNotifier{

  double result = 0.0;

  Future cashOutCalculation ({
    required BuildContext context,
    String? value,
    String? rate1,
    String? rate2,
    String? rate3,
    String? rate4,
    String? rate5,
    String? rate6,
    String? rate7,
  }) async{
    double newValue = double.parse(value!);
    double newRate1 = double.parse(rate1!);
    double newRate2 = double.parse(rate2!);
    double newRate3 = double.parse(rate3!);
    double newRate4 = double.parse(rate4!);
    double newRate5 = double.parse(rate5!);
    double newRate6 = double.parse(rate6!);
    double newRate7 = double.parse(rate7!);


    if(newValue >= 1 && newValue <=5) {
      var rate = (newValue * newRate1) /100;
      result = newValue + rate;
      notifyListeners();
    } else if (newValue >= 5 && newValue <=19){
      var rate = (newValue * newRate2) /100;
      result = newValue + rate;
      notifyListeners();
    } else if (newValue >= 20 && newValue <= 49) {
      var rate = (newValue * newRate3) / 100;
      result = newValue + rate;
      notifyListeners();
    }  else if (newValue >= 50 && newValue <= 99) {
      var rate = (newValue * newRate4) / 100;
      result = newValue + rate;
      notifyListeners();
    }  else if (newValue >= 100 && newValue <= 500) {
      var rate = (newValue * newRate5) / 100;
      result = newValue + rate;
      notifyListeners();
    }  else if (newValue >= 501 && newValue <= 999) {
      var rate = (newValue * newRate6) / 100;
      result = newValue + rate;
      notifyListeners();
    }
    else if (newValue >= 1000) {
      var rate = (newValue * newRate7) / 100;
      result = newValue + rate;
      notifyListeners();
    } return;
  }


  void initializer (){
    result = 0.0;
    notifyListeners();
  }

}