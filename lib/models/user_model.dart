import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? firstName;
  String? phoneNumber;
  String? country;
  String? confirmPassword;
  String? referenceCode;


  UserModel({
    this.firstName,
    this.phoneNumber,
    this.country,
    this.confirmPassword,
    this.referenceCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName,
      'phoneNumber': this.phoneNumber,
      'country': this.country,
      'confirmPassword': this.confirmPassword,
      'referenceCode' : "12334567890",
    };
  }

  factory UserModel.fromMap(DocumentSnapshot doc) {
    var data = doc.data()! as Map;
    return UserModel(
      firstName: data['firstName'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      country: data['country'] ?? "",
      confirmPassword: data['confirmPassword'] ?? "",
      referenceCode: data['referenceCode'],
    );
  }

  factory UserModel.initial(){
    return UserModel(
      firstName: '',
      country: '',
      phoneNumber: '',
      referenceCode: '',
      confirmPassword: '',
    );
  }

}