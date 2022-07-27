import 'package:expoin/models/models.dart';

enum CryptoToCryptoStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class CryptoToCryptoState{
  CryptoToCryptoStatus cryptoToCryptoStatus;
  CustomError? error;

  CryptoToCryptoState({
    required this.cryptoToCryptoStatus,
    this.error,
  });

  CryptoToCryptoState copyWith({
    CryptoToCryptoStatus? cryptoToCryptoStatus,
    CustomError? error,
  }) {
    return CryptoToCryptoState(
      cryptoToCryptoStatus: cryptoToCryptoStatus ?? this.cryptoToCryptoStatus,
      error: error ?? this.error,
    );
  }

  factory CryptoToCryptoState.init(){
    return CryptoToCryptoState(cryptoToCryptoStatus: CryptoToCryptoStatus.initial);
  }

}