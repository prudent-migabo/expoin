import 'package:expoin/models/models.dart';
import 'package:expoin/providers/cashOut_provider/retreive_cashout_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/cupertino.dart';

class RetreiveCashOutDetails with ChangeNotifier{
  CashOutRepository cashOutRepository;
  RateRepository rateRepository;
  RetreiveCashOutDetails({
    required this.cashOutRepository, required this.rateRepository,
  });

  RetreiveCashOutState _state = RetreiveCashOutState.init();
  RetreiveCashOutState get state => _state;
  double result = 0;
  Map data = {};

  Future<void> getCashOutDetails(String uid) async{
    _state = _state.copyWith(retreiveCashOutStatus: RetreiveCashOutStatus.isLoading);
    notifyListeners();

    try{
        data = await cashOutRepository.getDetails(uid);
        notifyListeners();
   //    Map rateData = await rateRepository.getRateValue(docID);
   //     result = double.parse(data["cryptoAmount"]??"") * double.parse(rateData["rate"]??"");
   //     notifyListeners();

      _state = _state.copyWith(retreiveCashOutStatus: RetreiveCashOutStatus.isLoaded, rateOperationResult: result);
      notifyListeners();


    } on CustomError catch(e){
      _state = _state.copyWith(retreiveCashOutStatus: RetreiveCashOutStatus.error, error: e);
      notifyListeners();
    }
    print("================== retreiveCashOut $result ===============");
  }

}