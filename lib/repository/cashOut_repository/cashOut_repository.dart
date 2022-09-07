import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class CashOutRepository {
  Map details = {};

  Future addCashOut(String uid, CashOutModel cashOutModel) async{
    try{
      await cashOutRef.doc(uid).set(cashOutModel.toMap());
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message.toString(), plugin: e.plugin);
    } on CustomError catch(e){
      throw CustomError(code: "Exception", message: e.message, plugin: "Exception/plugin");
    }
  }

  Stream<CashOutModel> getCashOutDetail(String uid){
    return cashOutRef.doc(uid).snapshots().map((doc) => CashOutModel.fromMap(doc));
  }


  Future getDetails(String uid) async{
    await cashOutRef.doc(uid).get().then((value) {
      details = value.data() as Map;
      }
    );
  return details;

  }
}