import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

  class UpdatePinCodeEvent extends MesPiecesEvent{
    String newPinCode;

    UpdatePinCodeEvent({
      required this.newPinCode,
    });

    @override
    Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{

      InformationRepository repository = InformationRepository();

      try {
        await repository.updatePin(newPinCode);
        yield PinCodeUpdated();
      } catch (e){
        yield ErrorState(
          message: e.toString(),
        );
      }
    }

  }
