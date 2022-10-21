import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class CashOutHistoricRepository{
  List<CashOutModel> listCashOut (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => CashOutModel.fromMap(docs)).toList();
  }

  Stream<List<CashOutModel>> getListCashOut(){
    return cashOutRef.orderBy('date', descending: true).snapshots().map(listCashOut);
  }

  Future deleteCashOutHistoric(String docID) async{
    await cashOutRef.doc(docID).delete();
  }

}