import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CashOutRepository{
  CashOutRepository({
    required this.auth,
  });
  FirebaseAuth auth;
  Future<void> addCashOut(CashOutModel cashOutModel) async{
    try{
      await cashOutRef.add(cashOutModel.toMap());
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch(e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }


}