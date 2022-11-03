import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/cupertino.dart';

class CashInProvider extends ChangeNotifier{
  CashInState _state = CashInState.init();
  CashInState get state => _state;
  CashInRepository cashInRepository;

  CashInProvider({
    required this.cashInRepository,
  });

  Future<void> addCashIn(CashInModel cashInModel) async{
    _state = _state.copyWith(cashInStatus: CashInStatus.isLoading);
    notifyListeners();
    try{
      await cashInRepository.addCashIn(cashInModel);
      _state = _state.copyWith(cashInStatus: CashInStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(cashInStatus: CashInStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(cashInStatus: CashInStatus.initial);
    notifyListeners();
  }


}