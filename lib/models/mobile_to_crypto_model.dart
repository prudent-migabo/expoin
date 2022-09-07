import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileToCryptoModel{
  String? transactionID;
  String? cryptoNumber;
  String? cryptoType;
  String? mobileAmount;
  String? amountToReceive;
  String? agentNumber;
  String? mobileOperator;

  MobileToCryptoModel({
    this.transactionID,
    this.cryptoNumber,
    this.cryptoType,
    this.mobileAmount,
    this.amountToReceive,
    this.agentNumber,
    this.mobileOperator,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionID': this.transactionID,
      'cryptoNumber': this.cryptoNumber,
      'cryptoType': this.cryptoType,
      'mobileAmount': this.mobileAmount,
      'amountToReceive': this.amountToReceive,
      'agentNumber': this.agentNumber,
      'mobileOperator': this.mobileOperator,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'date': DateTime.now(),
    };
  }

  factory MobileToCryptoModel.fromMap(DocumentSnapshot doc) {
    var documentSnapshot = doc.data()! as Map;
    return MobileToCryptoModel(
      transactionID: documentSnapshot['transactionID'] ?? "",
      cryptoNumber: documentSnapshot['cryptoNumber'] ?? "",
      cryptoType: documentSnapshot['cryptoType'] ?? "",
      mobileAmount: documentSnapshot['mobileAmount'] ?? "",
      amountToReceive: documentSnapshot['amountToReceive'] ?? "",
      agentNumber: documentSnapshot['agentNumber'] ?? "",
      mobileOperator: documentSnapshot['mobileOperator'] ?? "",
    );
  }

}