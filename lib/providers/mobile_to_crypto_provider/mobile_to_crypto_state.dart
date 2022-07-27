import 'package:expoin/models/models.dart';

enum MobileToCryptoStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class MobileToCryptoState{
  MobileToCryptoStatus mobileToCryptoStatus;
  CustomError? error;

  MobileToCryptoState({
    required this.mobileToCryptoStatus,
    this.error,
  });

  MobileToCryptoState copyWith({
    MobileToCryptoStatus? mobileToCryptoStatus,
    CustomError? error,
  }) {
    return MobileToCryptoState(
      mobileToCryptoStatus: mobileToCryptoStatus ?? this.mobileToCryptoStatus,
      error: error ?? this.error,
    );
  }

  factory MobileToCryptoState.init(){
    return MobileToCryptoState(mobileToCryptoStatus: MobileToCryptoStatus.initial);
  }

}