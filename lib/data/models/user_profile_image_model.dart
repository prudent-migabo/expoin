import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileImageModel {
  String? userProfileImageUrl;
  String? uid;
  String? createdAt;

//<editor-fold desc="Data Methods">
  UserProfileImageModel({
    this.userProfileImageUrl,
    this.uid,
    this.createdAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'userProfileImage': userProfileImageUrl,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': DateTime.now(),
    };
  }

  factory UserProfileImageModel.fromMap(DocumentSnapshot doc) {
    var map = doc.data() as Map;
    return UserProfileImageModel(
      userProfileImageUrl: map['userProfileImageUrl']??'',
      uid: map['uid'] ?? '',
    );
  }

}