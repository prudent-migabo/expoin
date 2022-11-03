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

  List<CashOutModel> listCashOut (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => CashOutModel.fromMap(docs)).toList();
  }

  Stream<List<CashOutModel>> getListCashOut(){
    return cashOutRef.where('uid', isEqualTo: auth.currentUser!.uid).snapshots().map(listCashOut);
  }

  Stream<List<CashOutModel>> getListCashOutOrdered(){
    return cashOutRef.orderBy('date', descending: true).snapshots().map(listCashOut);
  }

  Future deleteCashOutHistoric(String docID) async{
    await cashOutRef.doc(docID).delete();
  }

}