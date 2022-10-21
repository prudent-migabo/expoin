import 'package:expoin/models/models.dart';

enum CashInStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class CashInState{
  CashInStatus cashInStatus;
  CustomError? error;

  CashInState({
    required this.cashInStatus,
    this.error,
  });

  CashInState copyWith({
    CashInStatus? cashInStatus,
    CustomError? error,
  }) {
    return CashInState(
      cashInStatus: cashInStatus ?? this.cashInStatus,
      error: error ?? this.error,
    );
  }

  factory CashInState.init(){
    return CashInState(cashInStatus: CashInStatus.initial);
  }

}