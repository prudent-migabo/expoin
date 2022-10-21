import 'package:cloud_firestore/cloud_firestore.dart';

class HashNumberModel{
  String hashNumber;


  HashNumberModel({
    required this.hashNumber,
  });


  Map<String, dynamic> toMap() {
    return {
      'hashNumber': this.hashNumber,
    };
  }

  factory HashNumberModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return HashNumberModel(
      hashNumber: data['hashNumber'] ?? '',
    );
  }

//</editor-fold>
}