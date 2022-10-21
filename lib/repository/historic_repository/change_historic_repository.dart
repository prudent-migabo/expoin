import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class ChangeHistoricRepository{

  List<ChangeModel> listChange (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => ChangeModel.fromMap(docs)).toList();
  }

  Stream<List<ChangeModel>> getListChange(){
    return changeRef.orderBy('date', descending: true).snapshots().map(listChange);
  }

  Future deleteChangeHistoric(String docID) async{
    await changeRef.doc(docID).delete();
  }
}