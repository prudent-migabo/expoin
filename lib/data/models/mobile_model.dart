import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileMoneyModel {
  String? name;
  String? number;
  String? id;
  bool? isActive;

  MobileMoneyModel({
    this.number,
    this.name,
    this.id,
    this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'isActive': isActive,
      'createdAt': DateTime.now(),
    };
  }

  factory MobileMoneyModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map;
    return MobileMoneyModel(
      name: data['name']?? '',
      number: data['number'] ?? '',
      isActive: data['isActive'] ?? false,
      id: documentSnapshot.id,
    );
  }

}