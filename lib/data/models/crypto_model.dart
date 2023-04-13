import 'package:cloud_firestore/cloud_firestore.dart';

class CryptoModel {
  String? name;
  String? walletAddress;
  String? id;
  String? amount;
  bool? isActive;

//<editor-fold desc="Data Methods">
  CryptoModel({
    this.name,
    this.walletAddress,
    this.id,
    this.amount,
    this.isActive
  });


  factory CryptoModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data()! as Map;
    return CryptoModel(
      name: data['name'] ?? '',
      walletAddress: data['walletAddress'] ?? '',
      amount: data['amount'] ?? '',
      id: documentSnapshot.id,
      isActive: data['isActive'] ?? false,
    );
  }

//</editor-fold>
}