import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeRepository {
  ChangeRepository({
    this.auth,
  });

  FirebaseAuth? auth;

  Future<void> addChange(ChangeModel changeModel) async {
    try {
      await changeRef.add(changeModel.toMap());
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

  List<ChangeModel> listChange (QuerySnapshot snapshot){
    return snapshot.docs.map((docs) => ChangeModel.fromMap(docs)).toList();
  }

  Stream<List<ChangeModel>> getListChange(){
    return changeRef.where('uid', isEqualTo: auth!.currentUser!.uid).snapshots().map(listChange);
  }

  Stream<List<ChangeModel>> getListChangeOrdered(){
    return changeRef.orderBy('date', descending: true).snapshots().map(listChange);
  }

  Future deleteChangeHistoric(String docID) async{
    await changeRef.doc(docID).delete();
  }

}
