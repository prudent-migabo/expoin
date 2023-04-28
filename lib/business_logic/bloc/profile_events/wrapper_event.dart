import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class WrapperEvent extends MesPiecesEvent {
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    ProfileRepository repository = ProfileRepository();

    try{
      UserModel userModel = await repository.userInfo();
      print ('rrrrrrrrrrrrrrrrrrrrrrrrrrr ${userModel.lastName}, ${userModel.isBlocked}, ${userModel.isDeleted}');
      yield WrapperState(
        isBlocked: userModel.isBlocked,
        isDeleted: userModel.isDeleted,
        role: userModel.role,
        email: userModel.email,
      );
    }catch(e) {
      yield ErrorState();
    }

  }

}