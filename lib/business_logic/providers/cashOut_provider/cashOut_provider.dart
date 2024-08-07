
import 'package:flutter/cupertino.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class CashOutProvider extends ChangeNotifier{
  CashOutState _state = CashOutState.init();
  CashOutState get state => _state;
  CashOutRepository cashOutRepository;

  CashOutProvider({
    required this.cashOutRepository,
  });

  Future<void> addCashOut(CashOutModel cashOutModel) async{
    _state = _state.copyWith(cashOutStatus: CashOutStatus.isLoading);
    notifyListeners();
    try{
      await cashOutRepository.addCashOut(cashOutModel);
      _state = _state.copyWith(cashOutStatus: CashOutStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(cashOutStatus: CashOutStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(cashOutStatus: CashOutStatus.initial);
    notifyListeners();
  }

}