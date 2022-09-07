import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CryptoToCryptoModel{
  String? transactionID;
  String? cryptoType1;
  String? cryptoType2;
  String? cryptoAmount;
  String? amountToReceive;
  String? cryptoNumber;

//<editor-fold desc="Data Methods">

  CryptoToCryptoModel({
    this.transactionID,
    this.cryptoType1,
    this.cryptoType2,
    this.cryptoAmount,
    this.amountToReceive,
    this.cryptoNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionID': this.transactionID,
      'cryptoType1': this.cryptoType1,
      'cryptoType2': this.cryptoType2,
      'cryptoAmount': this.cryptoAmount,
      'amountToReceive': this.amountToReceive,
      'cryptoNumber': this.cryptoNumber,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'date': DateTime.now(),
    };
  }

  factory CryptoToCryptoModel.fromMap(DocumentSnapshot doc) {
    var documentSnapshot = doc.data()! as Map;
    return CryptoToCryptoModel(
      transactionID: documentSnapshot['transactionID'] ?? "",
      cryptoType1: documentSnapshot['cryptoType1'] ?? "",
      cryptoType2: documentSnapshot['cryptoType2'] ?? "",
      cryptoAmount: documentSnapshot['cryptoAmount'] ?? "",
      amountToReceive: documentSnapshot['amountToReceive'] ?? "",
      cryptoNumber: documentSnapshot['cryptoNumber'] ?? "",
    );
  }
}