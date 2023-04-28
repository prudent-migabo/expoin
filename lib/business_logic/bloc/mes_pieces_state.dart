import 'package:expoin/business_logic/business_logic.dart';

class InitialState extends MesPiecesState {}

class LoadingState extends MesPiecesState{}

class ErrorState extends MesPiecesState{
  String? message;

  ErrorState({
     this.message,
  });
}

class NoNetworkState extends MesPiecesState {}

class UserLoggedIn extends MesPiecesState{}

class ForgottenPasswordReset extends MesPiecesState{}

class UserLoggedOut extends MesPiecesState {}

class BoutiqueCreated extends MesPiecesState {}

class UserCreated extends MesPiecesState {}

class PasswordChanged extends MesPiecesState {}

class CryptosCreated extends MesPiecesState {}

class MobileMoneyCreated extends MesPiecesState {}

class BankTransferCreated extends MesPiecesState {}

class TokenSet extends MesPiecesState {}

class NotTokenSet extends MesPiecesState {}

class IsEmailVerified extends MesPiecesState{}

class IsNotEmailVerified extends MesPiecesState {}

class SuccessfulEmailVerification extends MesPiecesState {}

class CryptoCardSelected extends MesPiecesState {
  int ind;
  CryptoCardSelected({
    required this.ind,
  }) : super(index: ind);
}

class PinCodeSet extends MesPiecesState {}

class PinVerified extends MesPiecesState {}

class CryptoUpdated extends MesPiecesState{}

class UserDeleted extends MesPiecesState {}

class PhoneNumberUpdated extends MesPiecesState{}

class PinCodeUpdated extends MesPiecesState{}

class BoutiqueImageUploaded extends MesPiecesState {}

class UserInformationUploaded extends MesPiecesState {}

class GotCashInTotal extends MesPiecesState {
  double cashInTotal;

  GotCashInTotal({
    required this.cashInTotal,
  });
}

class WrapperState extends MesPiecesState {
  bool? isBlocked;
  bool? isDeleted;
  String? role;
  String? email;

  WrapperState({
    this.isBlocked,
    this.isDeleted,
    this.role,
    this.email,
  });
}