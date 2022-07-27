import 'package:expoin/models/models.dart';
import 'package:expoin/providers/crypto_to_mobile_provider/crypto_to_mobile_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/cupertino.dart';

class CryptoToMobileProvider extends ChangeNotifier{
  CryptoToMobileState _state = CryptoToMobileState.init();
  CryptoToMobileState get state => _state;
  CryptoToMobileRepository cryptoToMobileRepository;

  CryptoToMobileProvider({
    required this.cryptoToMobileRepository,
  });

  Future<void> addCryptoToMobile({String? transactionID, String? phone, String? cryptoType, String? cryptoAmount, String? amountToReceive}) async{
    _state = _state.copyWith(cryptoToMobileStatus: CryptoToMobileStatus.isLoading);
    notifyListeners();
    try{
      await cryptoToMobileRepository.addCryptoToMobile(transactionID!, phone!, cryptoType!, cryptoAmount!, amountToReceive!);
      _state = _state.copyWith(cryptoToMobileStatus: CryptoToMobileStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(cryptoToMobileStatus: CryptoToMobileStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(cryptoToMobileStatus: CryptoToMobileStatus.initial);
    notifyListeners();
  }

}