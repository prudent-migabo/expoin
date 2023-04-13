import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/utils/utils.dart';

class PinVerificationEvent extends MesPiecesEvent{
  String code;

  PinVerificationEvent({
    required this.code,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    InformationRepository repository = InformationRepository();
    try {
      await repository.getPinCode();
      if (MesPiecesBloc.pinCode == code){
        yield PinVerified();
      } else {
        yield ErrorState(
          message: 'Code pin incorrect, corrigez-le puis réssayez',
        );
      }
    } catch(e){
      yield ErrorState(
        message: e.toString(),
      );
    }
  }
}