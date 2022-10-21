import 'package:cloud_firestore/cloud_firestore.dart';

class CalculationModel{
  String? rate;

//<editor-fold desc="Data Methods">

  CalculationModel({
    this.rate,
  });


  Map<String, dynamic> toMap() {
    return {
      'rate': this.rate,
    };
  }

  factory CalculationModel.fromMap(DocumentSnapshot doc) {
    var data = doc.data() as Map;
    return CalculationModel(
      rate: data['rate'] ?? "",
    );
  }
}