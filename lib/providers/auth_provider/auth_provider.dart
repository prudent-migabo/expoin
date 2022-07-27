import 'package:expoin/providers/auth_provider/auth_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{
  AuthState _state = AuthState.initial();
  AuthState get state => _state;

  void update(User? user){
    if(user!=null){
      _state = _state.copyWith(authStatus: AuthStatus.authenticated);
      notifyListeners();
    } else {
      _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
      notifyListeners();
    }
  }
}

