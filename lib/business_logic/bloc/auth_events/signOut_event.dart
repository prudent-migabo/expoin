import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/business_logic/bloc/mes_pieces_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/repositories/repositories.dart';

import '../../../utils/utils.dart';

class SignOutEvent extends MesPiecesEvent{
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();

    try{
      await repository.signOut();
      yield UserLoggedOut();
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