import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class SaveCashInDetailsController with ChangeNotifier{
  CashInModel cashInModel = CashInModel.initial();
  var currentState;

  void saveCashInDetails (CashInModel newCashInModel){
    cashInModel = CashInModel(
        cryptoType: newCashInModel.cryptoType != '' ? newCashInModel.cryptoType : MesPiecesBloc.selectedCryptoName,
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