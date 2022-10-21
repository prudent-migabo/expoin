import 'package:expoin/models/models.dart';
import 'package:flutter/material.dart';

class SaveCashInDetailsController with ChangeNotifier{
  CashInModel cashInModel = CashInModel.initial();
  var currentState;

  void saveCashInDetails (CashInModel newCashInModel){
    cashInModel = CashInModel(
        cryptoType: newCashInModel.cryptoType != '' ? newCashInModel.cryptoType : cashInModel.cryptoType,
        amountToSend: newCashInModel.amountToSend != '' ? newCashInModel.amountToSend : cashInModel.amountToSend,
        hashNumber: newCashInModel.hashNumber != '' ? newCashInModel.hashNumber : cashInModel.hashNumber,
        mobileType: newCashInModel.mobileType != '' ? newCashInModel.mobileType : cashInModel.mobileType,
        transactionID: newCashInModel.transactionID != "" ? newCashInModel.transactionID : cashInModel.transactionID);
    notifyListeners();
  }

  void saveFormState (var newKey){
    currentState = newKey;
    notifyListeners();
  }



}