import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class UpdatePhoneEvent extends MesPiecesEvent{
  String newPhoneNumber;

  UpdatePhoneEvent({
    required this.newPhoneNumber,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    AuthRepository repository = AuthRepository();
    try {
      repository.updatePhone(newPhoneNumber);
      yield PhoneNumberUpdated();
    } catch(e){
      yield ErrorState(
        message: e.toString(),
      );
    }
  }

}