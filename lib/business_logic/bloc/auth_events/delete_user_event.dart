import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';

class DeleteUserEvent extends MesPiecesEvent{
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();

    try {
      await repository.deleteUserInFirestore(true);
      await repository.deleteUser();
      yield UserDeleted();
    }  on FirebaseException catch(e){
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