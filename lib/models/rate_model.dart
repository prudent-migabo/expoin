import 'package:cloud_firestore/cloud_firestore.dart';

class RateModel{
  String? rate;

//<editor-fold desc="Data Methods">

  RateModel({
    this.rate,
  });


  Map<String, dynamic> toMap() {
    return {
      'rate': this.rate,
    };
  }

  factory RateModel.fromMap(DocumentSnapshot doc) {
    var data = doc.data() as Map;
    return RateModel(
      rate: data['rate'] ?? "",
    );
  }
}