import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CryptoToMobileModel{
  String? transactionID;
  String? phone;
  String? cryptoType;
  String? cryptoAmount;
  String? amountToReceive;
  String? docID;
  String? uid;

//<editor-fold desc="Data Methods">

  CryptoToMobileModel({
    this.transactionID,
    this.phone,
    this.cryptoType,
    this.cryptoAmount,
    this.amountToReceive,
    this.docID,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionID': this.transactionID,
      'phone': this.phone,
      'cryptoType': this.cryptoType,
      'cryptoAmount': this.cryptoAmount,
      'amountToReceive': this.amountToReceive,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'date': DateTime.now(),
    };
  }

  factory CryptoToMobileModel.fromMap(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map;
    return CryptoToMobileModel(
      transactionID: snapshot['transactionID'] ?? "",
      phone: snapshot['phone'] ?? "",
      cryptoType: snapshot['cryptoType'] ?? "",
      cryptoAmount: snapshot['cryptoAmount'] ?? "",
      amountToReceive: snapshot['amountToReceive'] ?? "",
      docID: doc.id,
      uid: snapshot['uid'],
    );
  }

//</editor-fold>
}