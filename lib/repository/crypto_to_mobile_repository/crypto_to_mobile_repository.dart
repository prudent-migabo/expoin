import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CryptoToMobileRepository{
  CryptoToMobileRepository({
    this.auth,
  });
  FirebaseAuth? auth;
  Future<void> addCryptoToMobile(String transactionID, String phone, String cryptoType, String cryptoAmount, String amountToReceive) async{
    try{
      await cryptoToMobileRef.add({
        "transactionID": transactionID,
        "phone": phone,
        "cryptoType": cryptoType,
        "cryptoAmount": cryptoAmount,
        "amountToReceive": amountToReceive,
        "uid" : auth!.currentUser!.uid,
      });
    } on FirebaseException catch(e){
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch(e){
      throw CustomError(code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }

}