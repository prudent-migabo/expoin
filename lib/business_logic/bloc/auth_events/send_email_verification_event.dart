import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/utils/utils.dart';

class SendEmailVerificationEvent extends MesPiecesEvent{
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();
    try {
      await repository.emailVerification();
      yield EmailSent();
    } on FirebaseAuthException catch (e){
      yield ErrorState(
        message: AuthExceptionHandler.generateExceptionMessage(e.code),
      );
    }
    catch (e){
      yield ErrorState(
        message: e.toString(),
      );
    }
  }

}

class InitialVerificationEvent extends MesPiecesEvent {
 User? user = FirebaseAuth.instance.currentUser;
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
   await user!.reload();
    if (user!.emailVerified){
      yield IsEmailVerified();
    } else {
      yield IsNotEmailVerified();
    }
  }

}