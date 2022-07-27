import 'package:expoin/models/models.dart';

enum CryptoToMobileStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class CryptoToMobileState{
  CryptoToMobileStatus cryptoToMobileStatus;
  CustomError? error;

  CryptoToMobileState({
    required this.cryptoToMobileStatus,
    this.error,
  });

  CryptoToMobileState copyWith({
    CryptoToMobileStatus? cryptoToMobileStatus,
    CustomError? error,
  }) {
    return CryptoToMobileState(
      cryptoToMobileStatus: cryptoToMobileStatus ?? this.cryptoToMobileStatus,
      error: error ?? this.error,
    );
  }

  factory CryptoToMobileState.init(){
    return CryptoToMobileState(cryptoToMobileStatus: CryptoToMobileStatus.initial);
  }

}