import 'package:cloud_firestore/cloud_firestore.dart';

class BoutiqueModel {
  String? name;
  String? address;
  String? country;
  String? creationYear;
  String? email;
  String? phone;
  String? promoterName;
  String? referenceCode;
  String? docID;
  String? boutiqueName;
//<editor-fold desc="Data Methods">
  BoutiqueModel({
    this.name,
    this.address,
    this.country,
    this.creationYear,
    this.email,
    this.phone,
    this.promoterName,
    this.referenceCode,
    this.docID,
    this.boutiqueName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'country': country,
      'creationYear': creationYear,
      'email': email,
      'phone' : phone,
      'promoterName': promoterName,
      'referenceCode': referenceCode,
      'docID': docID,
      'boutiqueName' : boutiqueName,
    };
  }

  factory BoutiqueModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map map = documentSnapshot.data()! as Map;
    return BoutiqueModel(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      country: map['country'] ?? '',
      creationYear: map['creationYear'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      promoterName: map['promoterName'] ?? '',
      referenceCode: map['referenceCode'] ?? '',
      boutiqueName: map['boutiqueName'] ?? '',
      docID: documentSnapshot.id,
    );
  }

//</editor-fold>
}