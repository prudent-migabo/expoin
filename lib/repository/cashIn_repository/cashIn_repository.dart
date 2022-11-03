import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CashInRepository {
  CashInRepository({
    this.auth,
  });

  FirebaseAuth? auth;

  Future<void> addCashIn(CashInModel cashInModel) async {
    try {
      await cashInRef.add(cashInModel.toMap());
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

  List<CashInModel> listCashIn (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => CashInModel.fromMap(docs)).toList();
  }

  Stream<List<CashInModel>> getListCashIn(){
    return cashInRef.where('uid', isEqualTo: auth!.currentUser!.uid).snapshots().map(listCashIn);
  }

  Stream<List<CashInModel>> getListCashInOrdered(){
    return cashInRef.orderBy('date', descending: true).snapshots().map(listCashIn);
  }

  Future deleteCashInHistoric(String docID) async{
    await cashInRef.doc(docID).delete();
  }
}
