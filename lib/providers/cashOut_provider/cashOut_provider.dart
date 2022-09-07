import 'package:expoin/models/models.dart';
import 'package:expoin/providers/cashOut_provider/cashOut_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/material.dart';

class CashOutProvider with ChangeNotifier{
  CashOutRepository cashOutRepository;
  CashOutState _state = CashOutState.init();
  CashOutState get state => _state;
  CashOutModel cashOutModel = CashOutModel();

  CashOutProvider({required this.cashOutRepository});

  Future<void> addCashOut(String uid, CashOutModel cashOutModel) async{
    _state = _state.copyWith(cashOutStatus: CashOutStatus.isSubmitting);
    notifyListeners();

    try{
      await cashOutRepository.addCashOut(uid, cashOutModel);
      _state = _state.copyWith(cashOutStatus: CashOutStatus.success);
      notifyListeners();
    }
    on CustomError catch(e){
      _state = _state.copyWith(cashOutStatus: CashOutStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  void initial(){
    _state = _state.copyWith(cashOutStatus: CashOutStatus.initial);
    notifyListeners();
  }

}