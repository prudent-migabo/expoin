import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class GetCashInTotalEvent extends MesPiecesEvent {
  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{
    CashInRepository repository = CashInRepository();
    double totalAmount = 0.0;

   try{
      List<CashInModel>? list = repository.listCashInMonitor();
      for (var a in list) {
        totalAmount = totalAmount + double.parse(a.amountToSend);
      }

      yield GotCashInTotal(
        cashInTotal: totalAmount,
      );
   }
    catch (e){
      yield ErrorState(
        message: e.toString(),
      );
    }

  }


}