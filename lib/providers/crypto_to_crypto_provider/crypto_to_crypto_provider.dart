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

  Future<void> addCryptoToCrypto(CryptoToCryptoModel cryptoToCryptoModel) async{
    _state = _state.copyWith(cryptoToCryptoStatus: CryptoToCryptoStatus.isLoading);
    notifyListeners();
    try{
      await cryptoToCryptoRepository.addCryptoToCrypto(cryptoToCryptoModel);
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