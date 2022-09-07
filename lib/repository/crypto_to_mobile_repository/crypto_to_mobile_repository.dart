import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CryptoToMobileRepository{
  CryptoToMobileRepository({
    this.auth,
  });
  FirebaseAuth? auth;
  Future<void> addCryptoToMobile(CryptoToMobileModel cryptoToMobileModel) async{
    try{
      await cryptoToMobileRef.add(cryptoToMobileModel.toMap());
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch(e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

  List<CryptoToMobileModel> listCryptoToMobile (QuerySnapshot querySnapshot){
    return querySnapshot.docs.map((doc) => CryptoToMobileModel.fromMap(doc)).toList();
  }

  Stream<CryptoToMobileModel> getCryptoToMobile(String docID){
    return cryptoToMobileRef.doc(docID).snapshots().map((doc) => CryptoToMobileModel.fromMap(doc));
  }

  Stream<List<CryptoToMobileModel>> getListCryptoToMobile(){
    return cryptoToMobileRef.orderBy("date", descending: true).snapshots().map(listCryptoToMobile);
  }

}