import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';

class AuthRepository{
  String userToken = 'userToken';
  String userID = 'userID';
  FirebaseAuth? auth = FirebaseAuth.instance;
  FirebaseFirestore? ref = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  ///Login user to firebase
  Future login({required String email, required String password}) async{
    var response = await auth!.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }

  ///Update the existing user password
  Future updatePassword ({required String newPassword}) async{
    var response = await user!.updatePassword(newPassword);
    return response;
  }

  /// Reset the user forgotten password
  Future forgotPassword ({required String email}) async{
    var response = await auth!.sendPasswordResetEmail(email: email);
    return response;
  }

  /// Verification of the email
  Future emailVerification () async {
    var response = await user!.sendEmailVerification();
    return response;
  }

  /// SignOut the user
  Future signOut () async{
    var response = await auth!.signOut();
    return response;
  }

  /// Create the user to firebase
  Future register ({Map<String, dynamic>? data, required String email, required String password, String? collectionName}) async{
    await auth!.createUserWithEmailAndPassword(email: email, password: password);
    await userRef.doc(auth!.currentUser!.uid).set(data!);
  }


  Stream<UserModel> getUserInformation (){
    return userRef.doc(auth!.currentUser!.uid).snapshots().map((doc) => UserModel.fromMap(doc));
  }

  Future deleteUser () async{
      auth!.currentUser!.delete();
  }

  Future deleteUserInFirestore (bool deletionStatus) async{
    await userRef.doc(auth!.currentUser!.uid).update({'isDeleted' : deletionStatus});
  }
  
  Future updatePhone(String newPhoneNumber) async {
    await userRef.doc(auth!.currentUser!.uid).update({'phone': newPhoneNumber});
  }

}