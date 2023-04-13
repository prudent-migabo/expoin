import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletAddressModel {
  String? name;
  String? walletAddress;
  String? id;

//<editor-fold desc="Data Methods">
  WalletAddressModel({
    this.name,
    this.walletAddress,
    this.id,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'walletAddress': walletAddress,
      'createdAt': DateTime.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
    };
  }

  factory WalletAddressModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data()! as Map;
    return WalletAddressModel(
      name: data['name'] ?? '',
      walletAddress: data['walletAddress'] ?? '',
      id: documentSnapshot.id,
    );
  }

//</editor-fold>
}