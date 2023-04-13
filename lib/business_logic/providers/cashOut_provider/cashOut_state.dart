
import 'package:expoin/data/data.dart';

enum CashOutStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class CashOutState{
  CashOutStatus cashOutStatus;
  CustomError? error;

  CashOutState({
    required this.cashOutStatus,
    this.error,
  });

  CashOutState copyWith({
    CashOutStatus? cashOutStatus,
    CustomError? error,
  }) {
    return CashOutState(
      cashOutStatus: cashOutStatus ?? this.cashOutStatus,
      error: error ?? this.error,
    );
  }

  factory CashOutState.init(){
    return CashOutState(cashOutStatus: CashOutStatus.initial);
  }

}