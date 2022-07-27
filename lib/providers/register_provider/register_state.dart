import 'package:expoin/models/models.dart';

enum RegisterStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class RegisterState{
  RegisterStatus registerStatus;
  CustomError? error;

  RegisterState({
    required this.registerStatus,
    this.error,
  });

  RegisterState copyWith({
    RegisterStatus? registerStatus,
    CustomError? error,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      error: error ?? this.error,
    );
  }

  factory RegisterState.init(){
    return RegisterState(registerStatus: RegisterStatus.initial);
  }

}