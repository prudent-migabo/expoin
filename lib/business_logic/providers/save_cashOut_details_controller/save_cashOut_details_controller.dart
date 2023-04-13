import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class SaveCashOutDetailsController with ChangeNotifier{
  CashOutModel cashOutModel = CashOutModel.initial();

  void saveCashOutDetails (CashOutModel newCashOutModel){
    cashOutModel = CashOutModel(
        cryptoType: newCashOutModel.cryptoType != '' ? newCashOutModel.cryptoType : MesPiecesBloc.selectedCryptoName,
        amountToSend: newCashOutModel.amountToSend != '' ? newCashOutModel.amountToSend : cashOutModel.amountToSend,
        phoneMobileNumber: newCashOutModel.phoneMobileNumber != '' ? newCashOutModel.phoneMobileNumber : cashOutModel.phoneMobileNumber,
        transactionID: newCashOutModel.transactionID != "" ? newCashOutModel.transactionID : newCashOutModel.transactionID);
    notifyListeners();
  }

}