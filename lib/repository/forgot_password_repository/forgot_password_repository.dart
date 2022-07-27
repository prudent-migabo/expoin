import 'package:expoin/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordRepository{
  FirebaseAuth auth;
  ForgotPasswordRepository({
   required this.auth,
  });
  Future<void> resetPassword(String email) async{
    try{
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/plugin");
    }
  }

}