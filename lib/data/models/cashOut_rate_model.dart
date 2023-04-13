import 'package:cloud_firestore/cloud_firestore.dart';

class CashOutRateModel{
  String? rate1;
  String? rate2;
  String? rate3;
  String? rate4;
  String? rate5;
  String? rate6;
  String? rate7;

  CashOutRateModel({
    this.rate1,
    this.rate2,
    this.rate3,
    this.rate4,
    this.rate5,
    this.rate6,
    this.rate7,
  });

  Map<String, dynamic> toMap() {
    return {
      'rate1': rate1,
      'rate2': rate2,
      'rate3': rate3,
      'rate4': rate4,
      'rate5': rate5,
      'rate6': rate6,
      'rate7': rate7,
    };
  }

  factory CashOutRateModel.initial(){
    return CashOutRateModel(
      rate1: '',
      rate2: '',
      rate3: '',
      rate4: '',
      rate5: '',
      rate6: '',
      rate7: '',
    );
  }

  factory CashOutRateModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return CashOutRateModel(
      rate1: data['rate1'] ?? '',
      rate2: data['rate2'] ?? '',
      rate3: data['rate3'] ?? '',
      rate4: data['rate4'] ?? '',
      rate5: data['rate5'] ?? '',
      rate6: data['rate6'] ?? '',
      rate7: data ['rate7'] ?? '',
    );
  }

//</editor-fold>
}