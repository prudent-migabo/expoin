import 'package:expoin/models/models.dart';
import 'package:flutter/material.dart';

class SaveCashOutDetailsController with ChangeNotifier{
  CashOutModel cashOutModel = CashOutModel.initial();

  void saveCashOutDetails (CashOutModel newCashOutModel){
    cashOutModel = CashOutModel(
        cryptoType: newCashOutModel.cryptoType != '' ? newCashOutModel.cryptoType : cashOutModel.cryptoType,
        amountToSend: newCashOutModel.amountToSend != '' ? newCashOutModel.amountToSend : cashOutModel.amountToSend,
        phoneMobileNumber: newCashOutModel.phoneMobileNumber != '' ? newCashOutModel.phoneMobileNumber : cashOutModel.phoneMobileNumber,
        transactionID: newCashOutModel.transactionID != "" ? newCashOutModel.transactionID : newCashOutModel.transactionID);
    notifyListeners();
  }

}