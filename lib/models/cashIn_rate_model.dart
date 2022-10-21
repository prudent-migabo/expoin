import 'package:cloud_firestore/cloud_firestore.dart';

class CashInRateModel{
  String rate1;
  String rate2;
  String rate3;
  String rate4;

  CashInRateModel({
    required this.rate1,
    required this.rate2,
    required this.rate3,
    required this.rate4,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate1': this.rate1,
      'rate2': this.rate2,
      'rate3': this.rate3,
      'rate4': this.rate4,
    };
  }

  factory CashInRateModel.initial(){
    return CashInRateModel(
      rate1: '',
      rate2: '',
      rate3: '',
      rate4: '',
    );
  }

  factory CashInRateModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return CashInRateModel(
      rate1: data['rate1'] ?? '',
      rate2: data['rate2'] ?? '',
      rate3: data['rate3'] ?? '',
      rate4: data['rate4'] ?? '',
    );
  }

//</editor-fold>
}