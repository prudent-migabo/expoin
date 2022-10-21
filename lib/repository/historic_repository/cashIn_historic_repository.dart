import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class CashInHistoricRepository{

  List<CashInModel> listCashIn (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => CashInModel.fromMap(docs)).toList();
  }

  Stream<List<CashInModel>> getListCashIn(){
    return cashInRef.orderBy('date', descending: true).snapshots().map(listCashIn);
  }

  Future deleteCashInHistoric(String docID) async{
    await cashInRef.doc(docID).delete();
  }

}