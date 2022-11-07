import 'package:expoin/models/models.dart';
import 'package:flutter/material.dart';

class SaveChangeDetailsController with ChangeNotifier{
  ChangeModel changeModel = ChangeModel.initial();

  Future saveChangeDetails (ChangeModel newChangeModel) async{
    changeModel = ChangeModel(
        cryptoTypeToSend: newChangeModel.cryptoTypeToSend != '' ? newChangeModel.cryptoTypeToSend : changeModel.cryptoTypeToSend,
        cryptoTypeToReceive: newChangeModel.cryptoTypeToReceive != '' ? newChangeModel.cryptoTypeToReceive : changeModel.cryptoTypeToReceive,
        hashNumber: newChangeModel.hashNumber != '' ? newChangeModel.hashNumber : changeModel.hashNumber,
        cryptoAmountToSend: newChangeModel.cryptoAmountToSend != '' ? newChangeModel.cryptoAmountToSend : changeModel.cryptoAmountToSend,
        transactionMessage: newChangeModel.transactionMessage != "" ? newChangeModel.transactionMessage : changeModel.transactionMessage);
    notifyListeners();
  }

}