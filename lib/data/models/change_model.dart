import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String? uid;
  bool? isPending;
  String? boutiqueName;
  String? boutiqueID;

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
    this.uid,
    this.isPending,
    this.boutiqueName,
    this.boutiqueID,
  });


  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'cryptoTypeToSend': cryptoTypeToSend,
      'cryptoTypeToReceive': cryptoTypeToReceive,
      'cryptoAmountToSend': cryptoAmountToSend,
      'amountToReceive': amountToReceive,
      'hashNumber': hashNumber,
      'transactionMessage': transactionMessage,
      'date': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'isPending': true,
      'boutiqueName' : boutiqueName,
      'boutiqueID' : boutiqueID,
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
      boutiqueName: '',
      boutiqueID:  '',
    );
  }

  factory ChangeModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return ChangeModel(
      userName: data['userName'] ?? '',
      cryptoTypeToSend: data['cryptoTypeToSend'] ?? '',
      cryptoTypeToReceive: data['cryptoTypeToReceive'] ?? '',
      cryptoAmountToSend: data['cryptoAmountToSend'] ?? '',
      amountToReceive: data['amountToReceive'] ?? '',
      hashNumber: data['hashNumber'] ?? '',
      transactionMessage: data['transactionMessage'] ?? '',
      docID: documentSnapshot.id,
      isPending: data['isPending'] ?? true,
      boutiqueName: data['boutiqueName'] ?? '',
      boutiqueID: data['boutiqueID'],
    );
  }

}