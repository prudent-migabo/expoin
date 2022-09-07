import 'package:expoin/models/models.dart';

enum RateStatus{
  init,
  isLoading,
  isLoaded,
  error,
}

class RateState{
  RateStatus rateStatus;
  String? rate;
  CustomError? error;


  RateState({
    required this.rateStatus,
    this.rate,
    this.error,
  });

  RateState copyWith({
    RateStatus? rateStatus,
    String? rate,
    CustomError? error,
  }) {
    return RateState(
      rateStatus: rateStatus ?? this.rateStatus,
      rate: rate ?? this.rate,
      error: error ?? this.error,
    );
  }

  factory RateState.init() {
    return RateState(
      rateStatus: RateStatus.init,
      rate: "",
    );
  }

}