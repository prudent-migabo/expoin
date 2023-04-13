import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';

class RegisterWallets extends MesPiecesEvent{
  WalletAddressModel cryptoModel;
  String cryptoName;
  RegisterWallets({
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


