import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CashInModel{
  String? userName;
  String cryptoType;
  String amountToSend;
  String? amountToReceive;
  String hashNumber;
  String mobileType;
  String transactionID;
  String? date;
  String? docID;
  String? uid;
  bool? isPending;

//<editor-fold desc="Data Methods">

  CashInModel({
    this.userName,
    required this.cryptoType,
    required this.amountToSend,
    this.amountToReceive,
    required this.hashNumber,
    required this.mobileType,
    required this.transactionID,
     this.date,
    this.docID,
    this.uid,
    this.isPending,
  });


  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'cryptoType': this.cryptoType,
      'amountToSend': this.amountToSend,
      'hashNumber': this.hashNumber,
      'mobileType': this.mobileType,
      'transactionID': this.transactionID,
      'amountToReceive': this.amountToReceive,
      'date': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'isPending' : this.isPending,
    };
  }
    factory CashInModel.initial() {
      return CashInModel(
        userName: '',
        cryptoType: '',
        amountToSend: '',
        hashNumber: '',
        mobileType: '',
        transactionID: '',
        amountToReceive: '',
        uid: '',
        isPending: true,
      );
    }

    factory CashInModel.fromMap(DocumentSnapshot documentSnapshot){
    var data = documentSnapshot.data()! as Map;
    return CashInModel(
        cryptoType: data['cryptoType'] ?? '',
        amountToSend: data['amountToSend'] ?? '',
        hashNumber: data['hashNumber'] ?? '',
        mobileType: data['mobileType'] ?? '',
        transactionID: data['transactionID'] ?? '',
        amountToReceive: data['amountToReceive'],
        userName: data['userName']  ?? '',
      uid: data['uid'],
      isPending: data['isPending'],
      docID: documentSnapshot.id,
      );
    }

//</editor-fold>
}
