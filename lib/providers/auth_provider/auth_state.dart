import 'package:expoin/models/models.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  error,
}

class AuthState{
  AuthStatus authStatus;
  CustomError? error;

  AuthState({
    required this.authStatus,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    CustomError? error,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      error: error ?? this.error,
    );
  }

  factory AuthState.initial(){
    return AuthState(authStatus: AuthStatus.unauthenticated);
  }

}