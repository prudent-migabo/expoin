import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CryptoToCryptoRepository{
  CryptoToCryptoRepository({
    this.auth,
  });
  FirebaseAuth? auth;
  Future<void> addCryptoToCrypto(String transactionID, String cryptoType1, String cryptoType2, String cryptoAmount, String amountToReceive, String cryptoNumber) async{
    try{
      await cryptoToCryptoRef.add({
        "transactionID": transactionID,
        "cryptoType1": cryptoType1,
        "cryptoType2": cryptoType2,
        "cryptoAmount": cryptoAmount,
        "amountToReceive": amountToReceive,
        "cryptoNumber": cryptoNumber,
        "uid" : auth!.currentUser!.uid,
      });
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch(e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

}