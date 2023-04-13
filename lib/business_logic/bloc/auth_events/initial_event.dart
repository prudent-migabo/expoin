import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/repositories/repositories.dart';

class InitialEvent extends MesPiecesEvent{
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();
    // if (repository.getToken().isNotEmpty){
    //   yield TokenSet();
    // } else {
    //   yield NotTokenSet();
    // }
  }

}