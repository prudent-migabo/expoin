import 'package:expoin/models/models.dart';

enum LoginStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class LoginState{
  LoginStatus loginStatus;
  CustomError? error;

  LoginState({
    required this.loginStatus,
    this.error,
  });

  LoginState copyWith({
    LoginStatus? loginStatus,
    CustomError? error,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      error: error ?? this.error,
    );
  }

  factory LoginState.init(){
    return LoginState(loginStatus: LoginStatus.initial);
  }

}