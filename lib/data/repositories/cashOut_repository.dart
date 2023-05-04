import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class CashOutRepository{
  FirebaseAuth? auth = FirebaseAuth.instance;
  String cashOut = 'cashOut';
  String userCashOut = 'userCashOut';
  Future<void> addCashOut(CashOutModel cashOutModel) async{
    try{
      await transactionRef
          .doc(cashOut)
          .collection(userCashOut)
          .add(cashOutModel.toMap());
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch(e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

  List<CashOutModel> listCashOut (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => CashOutModel.fromMap(docs)).toList();
  }

  // Stream<List<CashOutModel>> getListCashOut(){
  //   return transactionRef
  //
  //       .snapshots().map(listCashOut);
  // }

  Stream<List<CashOutModel>> getListCashOutOrdered(){
    return transactionRef
        .doc(cashOut)
        .collection(userCashOut)
        .where('uid', isEqualTo: auth!.currentUser!.uid)
        .orderBy('date', descending: true).snapshots().map(listCashOut);
  }

  Future deleteCashOutHistoric(String docID) async{
    await transactionRef
        .doc(cashOut)
        .collection(userCashOut)
        .doc(docID).delete();
  }


}