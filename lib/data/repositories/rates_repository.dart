import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class RatesRepository{

  Stream<CashInRateModel> getCashIn(){
    return ratesRef.doc('cashInRates').snapshots().map((doc) => CashInRateModel.fromMap(doc));
  }

  Stream<CashOutRateModel> getCashOut(){
    return ratesRef.doc('cashOutRates').snapshots().map((doc) => CashOutRateModel.fromMap(doc));
  }

  Stream<ChangeRateModel> getChange(){
    return ratesRef.doc('changeRates').snapshots().map((doc) => ChangeRateModel.fromMap(doc));
  }

}
