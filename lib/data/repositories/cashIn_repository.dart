import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class CashInRepository {
  FirebaseAuth? auth = FirebaseAuth.instance;
  String cashIn = 'cashIn';
  String userCashIn = 'userCashIn';


  Future<void> addCashIn(CashInModel cashInModel) async {
    try {
      await transactionRef
          .doc(cashIn)
          .collection(userCashIn)
          .add(cashInModel.toMap());
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

  // Stream<CashInModel> getCashIn (){
  //   return transactionRef.
  // }

  List<CashInModel> listCashInMonitor({QuerySnapshot? snapshot}) {
    return snapshot!.docs.map((docs) => CashInModel.fromMap(docs)).toList();
  }

  List<CashInModel> listCashIn(QuerySnapshot snapshot) {
    return snapshot.docs.map((docs) => CashInModel.fromMap(docs)).toList();
  }

  Stream<List<CashInModel>> getListCashInOrdered() {
    return transactionRef
        .doc(cashIn)
        .collection(userCashIn)
        .where('uid', isEqualTo: auth!.currentUser!.uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map(listCashIn);
  }

  Future deleteCashInHistoric(String docID) async {
    await transactionRef
        .doc(cashIn)
        .collection(userCashIn)
        .doc(docID).delete();
  }
}
