import 'package:cloud_firestore/cloud_firestore.dart';

class PinModel {
  String? pinCode;

//<editor-fold desc="Data Methods">
  PinModel({
     this.pinCode,
  });


  Map<String, dynamic> toMap() {
    return {
      'pinCode': pinCode,
    };
  }

  factory PinModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return PinModel(
      pinCode: data['pinCode'] ?? '',
    );
  }

//</editor-fold>
}