
import 'package:cloud_firestore/cloud_firestore.dart';

class CashOutModel{
  String? cryptoType;
  String? mobileType;
  String? cryptoAmount;

//<editor-fold desc="Data Methods">

  CashOutModel({
     this.cryptoType,
     this.mobileType,
     this.cryptoAmount,
  });


  Map<String, dynamic> toMap() {
    return {
      'cryptoType': this.cryptoType,
      'mobileType': this.mobileType,
      'cryptoAmount': this.cryptoAmount,
    };
  }

  factory CashOutModel.fromMap(DocumentSnapshot doc) {
    var data = doc.data() as Map;
    return CashOutModel(
      cryptoType: data['cryptoType'] ?? "",
      mobileType: data['mobileType'] ?? "",
      cryptoAmount: data['cryptoAmount'] ?? "",
    );
  }

//</editor-fold>
}