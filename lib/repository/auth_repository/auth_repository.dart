import 'package:expoin/models/customError.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{
  AuthRepository({
    required this.auth,
  });
  FirebaseAuth auth;

Stream<User?> get userState => auth.userChanges();

  Future<void> createUser(String email, String password) async{
   try{
     await auth.createUserWithEmailAndPassword(email: email, password: password);
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

}