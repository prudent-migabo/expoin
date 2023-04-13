import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneNumbersModel{
  String airtel;
  String orange;
  String mpesa;

  PhoneNumbersModel({
    required this.airtel,
    required this.orange,
    required this.mpesa,
  });

  Map<String, dynamic> toMap() {
    return {
      'airtel': this.airtel,
      'orange': this.orange,
      'mpesa': this.mpesa,
    };
  }

  factory PhoneNumbersModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return PhoneNumbersModel(
      airtel: data['airtel'] ?? '',
      orange: data['orange'] ?? '',
      mpesa: data['mpesa'] ?? '',
    );
  }

//</editor-fold>
}