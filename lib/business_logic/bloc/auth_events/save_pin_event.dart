import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/models/models.dart';
import 'package:expoin/data/repositories/repositories.dart';

import '../mes_pieces_bloc.dart';

class SavePinEvent extends MesPiecesEvent{
  PinModel pinModel;

  SavePinEvent({
    required this.pinModel,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    InformationRepository repository = InformationRepository();

    try {
      await repository.savePin(data: pinModel.toMap());
      yield PinCodeSet();
    } catch (e) {
      yield ErrorState(
        message: e.toString(),
      );
    }
  }



}