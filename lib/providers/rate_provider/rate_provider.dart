import 'package:expoin/models/models.dart';
import 'package:expoin/providers/rate_provider/rate_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/material.dart';

class RateProvider with ChangeNotifier{
  RateRepository rateRepository;
  RateState _state = RateState.init();
  RateState get state => _state;

  double result = 0;
  Map data = {};

  RateProvider({
    required this.rateRepository,
  });

  Future getRateValue(String docID) async{
    _state = _state.copyWith(rateStatus: RateStatus.isLoading);
    notifyListeners();
    try{
       data = await rateRepository.getRateValue(docID);
       notifyListeners();
      _state = _state.copyWith(rateStatus: RateStatus.isLoaded, rate: data["rate"]);
      notifyListeners();
    //  print("-----------------------rate provider${data["rate"]}, ${data["docID"]}-----------------------");
    } on CustomError catch(e){
      _state = _state.copyWith(rateStatus: RateStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  // void rateResult(String cryptoType, String rate){
  //   result = double.parse(cryptoType) * double.parse(rate);
  //   notifyListeners();
  //   print("+++++++++++++++++++++$result ++++++++++++++++");
  // }

}