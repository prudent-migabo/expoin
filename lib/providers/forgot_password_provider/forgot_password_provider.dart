import 'package:expoin/models/models.dart';
import 'package:expoin/providers/forgot_password_provider/forgot_password_state.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier{
  ForgotPasswordState _state = ForgotPasswordState.initial();
  ForgotPasswordState get state => _state;
  ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordProvider({
    required this.forgotPasswordRepository,
  });

  Future<void> resetPassword({String? email}) async{
    _state = _state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.isLoading);
    notifyListeners();
    try{
      await forgotPasswordRepository.resetPassword(email!);
      _state = _state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.isLoaded);
      notifyListeners();
    } on CustomError catch(e){
      _state = _state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> initial () async{
    _state = _state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.initial);
    notifyListeners();
  }

}