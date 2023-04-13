import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class UpdateWalletEvent extends MesPiecesEvent {
  String newWalletAddress;
  String cryptoName;

  UpdateWalletEvent({
    required this.newWalletAddress,
    required this.cryptoName,
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    InformationRepository repository = InformationRepository();

    try {
      await repository.updateWalletAddress(cryptoName: cryptoName, newWalletAddress: newWalletAddress);
      yield CryptoUpdated();
    } catch(e){
      yield ErrorState();
    }

  }



}