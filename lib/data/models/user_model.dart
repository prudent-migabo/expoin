import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? lastName;
  String? dateOfBirth;
  String? country;
  String? phone;
  String? email;
  String? referenceCode;
  String? profileImgUrl;

//<editor-fold desc="Data Methods">
  UserModel({
    this.lastName,
    this.dateOfBirth,
    this.country,
    this.phone,
    this.email,
    this.referenceCode,
    this.profileImgUrl,
  });


  Map<String, dynamic> toMap() {
    return {
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'country': country,
      'phone': phone,
      'email': email,
      'referenceCode': referenceCode,
      'profileImgUrl' : profileImgUrl,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data()! as Map;
    return UserModel(
      lastName: data['lastName'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      country: data['country'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      referenceCode: data['referenceCode'] ?? '',
      profileImgUrl: data['profileImgUrl'] ?? '',
    );
  }

  factory UserModel.initial(){
    return UserModel(
      lastName: '',
      country: '',
      phone: '',
      referenceCode: '',
      dateOfBirth: '',
      email: '',
      profileImgUrl: '',
    );
  }

}