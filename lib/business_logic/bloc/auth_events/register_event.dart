import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/models/models.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/utils/utils.dart';

class RegisterUser extends MesPiecesEvent{
  String email;
  String password;
  UserModel? userModel;

  RegisterUser({
    required this.email,
    required this.password,
    this.userModel,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();

    try{
      await repository.register(
        email: email,
        password: password,
        data: userModel!.toMap(),
      );
      yield UserCreated();
    } on FirebaseAuthException catch(e){
      print('errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrregisterccccccccccccccccccccccccode ${e.code}');
      yield ErrorState(
        message: AuthExceptionHandler.generateExceptionMessage(e.code),
      );
    } catch (e){
      yield ErrorState(
        message: e.toString(),
      );
    }

  }
}

