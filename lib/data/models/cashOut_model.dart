import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CashOutModel{
  String? userName;
  String? cryptoType;
  String? amountToSend;
  String? amountToReceive;
  String? phoneMobileNumber;
  String? transactionID;
  String? date;
  String? docID;
  String? uid;
  bool? isPending;
  String? boutiqueID;
  String? boutiqueName;

//<editor-fold desc="Data Methods">

  CashOutModel({
    this.userName,
    this.cryptoType,
    this.amountToSend,
    this.amountToReceive,
    this.phoneMobileNumber,
    this.transactionID,
    this.date,
    this.docID,
    this.uid,
    this.isPending,
    this.boutiqueID,
    this.boutiqueName,
  });


  Map<String, dynamic> toMap() {
    return {
      'userName' : userName,
      'cryptoType': cryptoType,
      'amountToSend': amountToSend,
      'amountToReceive': amountToReceive,
      'phoneMobileNumber': phoneMobileNumber,
      'transactionID': transactionID,
      'date': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'isPending' : isPending,
      'boutiqueID' : boutiqueID,
      'boutiqueName' : boutiqueName,
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
      boutiqueID: '',
      boutiqueName: '',
    );
  }

  factory CashOutModel.fromMap(DocumentSnapshot documentSnapshot){
    var data = documentSnapshot.data()! as Map;
    return CashOutModel(
        cryptoType: data['cryptoType'] ?? '',
        amountToSend: data['amountToSend'] ?? '',
        amountToReceive: data['amountToReceive'] ?? '',
        phoneMobileNumber: data['phoneMobileNumber'] ?? '',
        transactionID: data['transactionID'] ?? '',
        userName: data['userName'] ?? '',
      isPending: data['isPending'] ?? true,
      docID: documentSnapshot.id,
      boutiqueID: data['boutiqueID'] ?? '',
      boutiqueName: data['boutiqueName'] ?? '',
    );
  }

}