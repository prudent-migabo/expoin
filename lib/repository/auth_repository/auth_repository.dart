import 'package:expoin/models/customError.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{
  AuthRepository({
    required this.auth,
  });
  FirebaseAuth auth;

Stream<User?> get userState => auth.userChanges();
String get uid => auth.currentUser!.uid;

  Future<void> createUser(String email, String password, UserModel userModel) async{
   try{
     await auth.createUserWithEmailAndPassword(email: email, password: password);
     await userRef.doc(uid).set(userModel.toMap());
   } on FirebaseAuthException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
   }
   catch(e){
     throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/plugin");
   }
  }

  Future<void> signInUser (String email, String password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    }
    catch(e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/plugin");
    }
  }

  Future<void> signOutUSer() async{
    await auth.signOut();
  }

  Stream<UserModel> getUserName (){
    return userRef.doc(auth.currentUser!.uid).snapshots().map((doc) => UserModel.fromMap(doc));
  }


}