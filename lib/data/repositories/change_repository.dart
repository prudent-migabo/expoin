import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class ChangeRepository {

  FirebaseAuth? auth = FirebaseAuth.instance;
  String change = 'change';
  String userChange = 'userChange';

  Future<void> addChange(ChangeModel changeModel) async {
    try {
      await transactionRef
          .doc(change)
          .collection(userChange)
          .add(changeModel.toMap());
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
    return transactionRef.snapshots().map(listChange);
  }

  Stream<List<ChangeModel>> getListChangeOrdered(){
    return transactionRef
        .doc(change)
        .collection(userChange)
        .where('uid', isEqualTo: auth!.currentUser!.uid)
        .orderBy('date', descending: true).snapshots().map(listChange);
  }

  Future deleteChangeHistoric(String docID) async{
    await transactionRef
        .doc(change)
        .collection(userChange)
        .doc(docID).delete();
  }

}
