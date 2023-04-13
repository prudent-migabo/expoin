import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/utils/utils.dart';

class LoginEvent extends MesPiecesEvent {
  String email;
  String password;

  LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async* {
    AuthRepository repository = AuthRepository();
    try {
      await repository.login(email: email, password: password);
      yield UserLoggedIn();
    }
    on FirebaseAuthException catch(e){
      print ('errorrrrrrrrrrrrrrrrrrrrrrrrrrloginccccccccccccode ${e.code}');
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