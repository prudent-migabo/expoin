
import 'package:flutter/cupertino.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class ChangeProvider extends ChangeNotifier{
  ChangeState _state = ChangeState.init();
  ChangeState get state => _state;
  ChangeRepository changeRepository;

  ChangeProvider({
    required this.changeRepository,
  });

  Future<void> addChange(ChangeModel changeModel) async{
    _state = _state.copyWith(changeStatus: ChangeStatus.isLoading);
    notifyListeners();
    try{
      await changeRepository.addChange(changeModel);
      _state = _state.copyWith(changeStatus: ChangeStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(changeStatus: ChangeStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(changeStatus: ChangeStatus.initial);
    notifyListeners();
  }

}