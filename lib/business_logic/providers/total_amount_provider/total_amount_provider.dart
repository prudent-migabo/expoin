import 'package:flutter/material.dart';
import 'package:expoin/data/data.dart';

class TotalAmountProvider extends ChangeNotifier {
  final CashInRepository _cashInRepository = CashInRepository();
  final CashOutRepository _cashOutRepository = CashOutRepository();
  final ChangeRepository _changeRepository = ChangeRepository();

  String? cashInAmountSent;
  String cashInAmountReceived = '';
  String cashOutAmountSent = '';
  String cashOutAmountReceived = '';
  String changeAmountSent = '';
  String changeAmountReceived = '';

  Future getCashInInfo() async {
    await for (List<CashInModel> list in _cashInRepository
        .getListCashInOrdered()) {
      for (CashInModel cashInModel in list){
        cashInAmountSent = cashInModel.amountToSend;
        cashInAmountReceived = cashInModel.amountToReceive!;
        notifyListeners();
      }
    }

  }

  Future getCashOutInfo() async {
    await for (List<CashOutModel> list in _cashOutRepository
        .getListCashOutOrdered()) {
      list.map((e) {
        cashOutAmountSent = e.amountToSend!;
        cashOutAmountReceived = e.amountToReceive!;
        notifyListeners();
      });
    }
  }

  Future getChangeInfo() async {
    await for (List<ChangeModel> list in _changeRepository
        .getListChangeOrdered()) {
      list.map((e) {
        cashInAmountSent = e.cryptoAmountToSend;
        cashInAmountReceived = e.amountToReceive!;
        notifyListeners();
      });
    }
  }

  String totalAmount() {
    print(
        'app total amount issssssssssssssssssssssssssssssssssssssssssssssss ${cashInAmountSent !+
            cashInAmountReceived + cashOutAmountSent + cashOutAmountReceived +
            changeAmountSent + changeAmountReceived
        }');
    return cashInAmountSent! + cashInAmountReceived + cashOutAmountSent +
        cashOutAmountReceived + changeAmountSent + changeAmountReceived;
  }

}