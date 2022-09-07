import 'package:expoin/models/models.dart';

enum CashOutStatus{
  initial,
  isSubmitting,
  success,
  error,
}

class CashOutState {
  CashOutStatus cashOutStatus;
  CustomError? error;
  String? cryptoAmount;

  CashOutState({
    required this.cashOutStatus,
    this.error,
    this.cryptoAmount
  });


  CashOutState copyWith({
    CashOutStatus? cashOutStatus,
    CustomError? error,
    String? cryptoAmount,
  }) {
    return CashOutState(
      cashOutStatus: cashOutStatus ?? this.cashOutStatus,
      error: error ?? this.error,
      cryptoAmount: cryptoAmount ?? this.cryptoAmount,
    );
  }

  factory CashOutState.init() {
    return CashOutState(cashOutStatus: CashOutStatus.initial);
  }

}