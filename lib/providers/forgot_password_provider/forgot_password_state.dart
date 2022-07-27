import 'package:expoin/models/models.dart';

enum ForgotPasswordStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class ForgotPasswordState{
  ForgotPasswordStatus forgotPasswordStatus;
  CustomError? error;

  ForgotPasswordState({
    required this.forgotPasswordStatus,
    this.error,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? forgotPasswordStatus,
    CustomError? error,
  }) {
    return ForgotPasswordState(
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
      error: error ?? this.error,
    );
  }


  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      forgotPasswordStatus: ForgotPasswordStatus.initial,
    );
  }

}