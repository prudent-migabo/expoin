import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeModel{
  String? userName;
  String cryptoTypeToSend;
  String cryptoTypeToReceive;
  String cryptoAmountToSend;
  String? amountToReceive;
  String hashNumber;
  String transactionMessage;
  String? date;
  String? docID;
  bool? isPending;

//<editor-fold desc="Data Methods">

  ChangeModel({
    this.userName,
    required this.cryptoTypeToSend,
    required this.cryptoTypeToReceive,
    required this.cryptoAmountToSend,
    this.amountToReceive,
    required this.hashNumber,
    required this.transactionMessage,
    this.date,
    this.docID,
    this.isPending,
  });


  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'cryptoTypeToSend': this.cryptoTypeToSend,
      'cryptoTypeToReceive': this.cryptoTypeToReceive,
      'cryptoAmountToSend': this.cryptoAmountToSend,
      'amountToReceive': this.amountToReceive,
      'hashNumber': this.hashNumber,
      'transactionMessage': this.transactionMessage,
      'date': DateTime.now(),
      'isPending': this.isPending,
    };
  }

  factory ChangeModel.initial(){
    return ChangeModel(
        cryptoTypeToSend: '',
        cryptoTypeToReceive: '',
        cryptoAmountToSend: '',
        amountToReceive: '',
        hashNumber: '',
        transactionMessage: '',
      userName: '',
      isPending: true,
    );
  }

  factory ChangeModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return ChangeModel(
      userName: data['userName'] ?? '',
      cryptoTypeToSend: data['cryptoTypeToSend'] ?? '',
      cryptoTypeToReceive: data['cryptoTypeToReceive'] ?? '',
      cryptoAmountToSend: data['cryptoAmountToSend'] ?? '',
      amountToReceive: data['amountToReceive'],
      hashNumber: data['hashNumber'] ?? '',
      transactionMessage: data['transactionMessage'] ?? '',
      docID: documentSnapshot.id,
      isPending: data['isPending'] ?? true,
    );
  }

}