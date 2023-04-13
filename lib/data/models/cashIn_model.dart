import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CashInModel{
  String? userName;
  String? cryptoType;
  String amountToSend;
  String? amountToReceive;
  String hashNumber;
  String mobileType;
  String transactionID;
  String? date;
  String? docID;
  String? uid;
  bool? isPending;
  String? boutiqueID;

//<editor-fold desc="Data Methods">

  CashInModel({
    this.userName,
    this.cryptoType,
    required this.amountToSend,
    this.amountToReceive,
    required this.hashNumber,
    required this.mobileType,
    required this.transactionID,
     this.date,
    this.docID,
    this.uid,
    this.isPending,
    this.boutiqueID,
  });


  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'cryptoType': cryptoType,
      'amountToSend': amountToSend,
      'hashNumber': hashNumber,
      'mobileType': mobileType,
      'transactionID': transactionID,
      'amountToReceive': amountToReceive,
      'date': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'isPending' : isPending,
      'boutiqueID' : boutiqueID,
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
        boutiqueID: '',
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
        amountToReceive: data['amountToReceive'] ?? '',
        userName: data['userName']  ?? '',
      uid: data['uid'],
      isPending: data['isPending'],
      docID: documentSnapshot.id,
      boutiqueID: data['boutiqueID'],
      );
    }

//</editor-fold>
}
