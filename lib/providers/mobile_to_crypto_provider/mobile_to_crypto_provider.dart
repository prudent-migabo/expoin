import 'package:expoin/models/models.dart';
import 'package:expoin/providers/mobile_to_crypto_provider/mobile_to_crypto_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/cupertino.dart';

class MobileToCryptoProvider extends ChangeNotifier{
  MobileToCryptoState _state = MobileToCryptoState.init();
  MobileToCryptoState get state => _state;
  MobileToCryptoRepository mobileToCryptoRepository;

  MobileToCryptoProvider({
    required this.mobileToCryptoRepository,
  });

  Future<void> addMobileToCrypto({String? transactionID, String? cryptoNumber, String? cryptoType, String? mobileAmount, String? amountToReceive,String?agentNumber, String? mobileOperator}) async{
    _state = _state.copyWith(mobileToCryptoStatus: MobileToCryptoStatus.isLoading);
    notifyListeners();
    try{
      await mobileToCryptoRepository.addMobileToCrypto(transactionID!, cryptoNumber!, cryptoType!, mobileAmount!, amountToReceive!, agentNumber!, mobileOperator!);
      _state = _state.copyWith(mobileToCryptoStatus: MobileToCryptoStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(mobileToCryptoStatus: MobileToCryptoStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(mobileToCryptoStatus: MobileToCryptoStatus.initial);
    notifyListeners();
  }

}