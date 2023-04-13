import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class RegisterWalletEvent extends MesPiecesEvent{
  WalletAddressModel cryptoModel;
  String cryptoName;
  RegisterWalletEvent({
    required this.cryptoModel,
    required this.cryptoName,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async* {
    InformationRepository repository = InformationRepository();

    try{
      await repository.registerWalletAddress(
        data: cryptoModel.toMap(),
        cryptoName: cryptoName,
      );
      yield CryptosCreated();
    } catch (e) {
      yield ErrorState(
        message: e.toString(),
      );
    }
  }
}