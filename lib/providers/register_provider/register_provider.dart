import 'package:expoin/models/customError.dart';
import 'package:expoin/providers/login_provider/login_state.dart';
import 'package:expoin/providers/register_provider/register_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier{
  AuthRepository authRepository;
  RegisterProvider({required this.authRepository});
  RegisterState _state = RegisterState.init();
  RegisterState get state => _state;

  Future<void> createUser({String? email, String? password}) async{
    _state = _state.copyWith(registerStatus: RegisterStatus.isLoading);
    notifyListeners();
    try{
      await authRepository.createUser(email!, password!);
      _state = _state.copyWith(registerStatus: RegisterStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(registerStatus: RegisterStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initialState () async{
    _state = _state.copyWith(registerStatus: RegisterStatus.initial);
    notifyListeners();
  }

}