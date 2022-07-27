import 'package:expoin/models/models.dart';
import 'package:expoin/providers/crypto_to_crypto_provider/crypto_to_crypto_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/cupertino.dart';

class CryptoToCryptoProvider extends ChangeNotifier{
  CryptoToCryptoState _state = CryptoToCryptoState.init();
  CryptoToCryptoState get state => _state;
  CryptoToCryptoRepository cryptoToCryptoRepository;

  CryptoToCryptoProvider({
    required this.cryptoToCryptoRepository,
  });

  Future<void> addCryptoToCrypto({String? transactionID, String? cryptoType1, String? cryptoType2, String? cryptoAmount, String? amountToReceive, String? cryptoNumber}) async{
    _state = _state.copyWith(cryptoToCryptoStatus: CryptoToCryptoStatus.isLoading);
    notifyListeners();
    try{
      await cryptoToCryptoRepository.addCryptoToCrypto(transactionID!, cryptoType1!, cryptoType2!, cryptoAmount!, amountToReceive!, cryptoNumber!);
      _state = _state.copyWith(cryptoToCryptoStatus: CryptoToCryptoStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(cryptoToCryptoStatus: CryptoToCryptoStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(cryptoToCryptoStatus: CryptoToCryptoStatus.initial);
    notifyListeners();
  }

}