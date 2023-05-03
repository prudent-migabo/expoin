import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class ProfileRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<UserModel> getUserModel (){
    return userRef.doc(auth.currentUser!.uid).snapshots().map((doc) => UserModel.fromMap(doc));
  }


  Future addUserProfileImage (Map<String, dynamic> data) async {
    await userProfileImageRef.doc(auth.currentUser!.uid).set(data);
  }

  Stream<UserProfileImageModel> getProfileImage (){
    return userProfileImageRef.doc(auth.currentUser!.uid).snapshots().map((event) => UserProfileImageModel.fromMap(event));
  }

  Future updateUserInfo (String profileImgUrl, String userName) async{
    await userRef.doc(auth.currentUser!.uid).update({'profileImgUrl' : profileImgUrl, 'lastName' : userName});
  }


  Future<String> getImageUrl (File? pickedImage) async{
    String url;
    if (pickedImage == null){
      print('erreurrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    }
    final ref = FirebaseStorage.instance.ref().child('users-profile-images').child(pickedImage!.path);
    await ref.putFile(pickedImage);
    url = await ref.getDownloadURL();
    return url;
  }

  Future<UserModel> userInfo () async{
    var c = await userRef.doc(auth.currentUser!.uid).get();
    return UserModel.fromMap(c);
  }

}