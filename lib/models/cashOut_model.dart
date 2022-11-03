import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CashOutModel{
  String? userName;
  String cryptoType;
  String amountToSend;
  String? amountToReceive;
  String phoneMobileNumber;
  String transactionID;
  String? date;
  String? docID;
  String? uid;
  bool? isPending;

//<editor-fold desc="Data Methods">

  CashOutModel({
    this.userName,
    required this.cryptoType,
    required this.amountToSend,
    this.amountToReceive,
    required this.phoneMobileNumber,
    required this.transactionID,
    this.date,
    this.docID,
    this.uid,
    this.isPending,
  });


  Map<String, dynamic> toMap() {
    return {
      'userName' : this.userName,
      'cryptoType': this.cryptoType,
      'amountToSend': this.amountToSend,
      'amountToReceive': this.amountToReceive,
      'phoneMobileNumber': this.phoneMobileNumber,
      'transactionID': this.transactionID,
      'date': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'isPending' : this.isPending,
    };
  }

  factory CashOutModel.initial() {
    return CashOutModel(
       userName: '',
      cryptoType: '',
      amountToSend: '',
      amountToReceive: '',
      phoneMobileNumber: '',
      transactionID: '',
      uid: '',
      isPending: true,
    );
  }

  factory CashOutModel.fromMap(DocumentSnapshot documentSnapshot){
    var data = documentSnapshot.data()! as Map;
    return CashOutModel(
        cryptoType: data['cryptoType'] ?? '',
        amountToSend: data['amountToSend'] ?? '',
        amountToReceive: data['amountToReceive'],
        phoneMobileNumber: data['phoneMobileNumber'] ?? '',
        transactionID: data['transactionID'] ?? '',
        userName: data['userName'] ?? '',
      isPending: data['isPending'] ?? true,
      docID: documentSnapshot.id,
    );
  }

}