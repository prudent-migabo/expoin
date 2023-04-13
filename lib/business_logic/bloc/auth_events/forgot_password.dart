import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/repositories/repositories.dart';
import '../../../utils/utils.dart';


class ForgotPassword extends MesPiecesEvent{
  String email;

  ForgotPassword({
    required this.email,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();

    try {
      await repository.forgotPassword(email: email);
      yield ForgottenPasswordReset();
    } on FirebaseAuthException catch(e){
      yield ErrorState(
        message: AuthExceptionHandler.generateExceptionMessage(e.code),
      );
    }
    catch (e) {
      yield ErrorState(
        message: e.toString(),
      );
    }

  }


}