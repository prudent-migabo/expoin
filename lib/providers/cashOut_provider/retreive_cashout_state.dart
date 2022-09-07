

import 'package:expoin/models/models.dart';

enum RetreiveCashOutStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class RetreiveCashOutState{
  RetreiveCashOutStatus retreiveCashOutStatus;
  String cryptoAmount;
  Map? data;
  double? rateOperationResult;
  CustomError? error;

  RetreiveCashOutState({
    required this.retreiveCashOutStatus,
    required this.cryptoAmount,
    this.data,
    this.rateOperationResult,
    this.error,
  });


  RetreiveCashOutState copyWith({
    RetreiveCashOutStatus? retreiveCashOutStatus,
    String? cryptoAmount,
    Map? data,
    double? rateOperationResult,
    CustomError? error,
  }) {
    return RetreiveCashOutState(
      retreiveCashOutStatus:
          retreiveCashOutStatus ?? this.retreiveCashOutStatus,
      cryptoAmount: cryptoAmount ?? this.cryptoAmount,
      data: data ?? this.data,
      rateOperationResult: this.rateOperationResult,
      error: error ?? this.error,
    );
  }


  factory RetreiveCashOutState.init() {
    return RetreiveCashOutState(
      retreiveCashOutStatus: RetreiveCashOutStatus.initial,
      cryptoAmount: "",
      data: {},
      rateOperationResult: 0.0,
    );
  }

}