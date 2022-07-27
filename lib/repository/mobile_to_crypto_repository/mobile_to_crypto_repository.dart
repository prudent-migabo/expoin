import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileToCryptoRepository {
  MobileToCryptoRepository({
    this.auth,
  });

  FirebaseAuth? auth;

  Future<void> addMobileToCrypto(
    String transactionID,
    String cryptoNumber,
    String cryptoType,
    String mobileAmount,
    String amountToReceive,
    String agentNumber,
      String mobileOperator,
  ) async {
    try {
      await mobileToCryptoRef.doc(auth!.currentUser!.uid).set({
        "transactionID": transactionID,
        "cryptoNumber": cryptoNumber,
        "cryptoType": cryptoType,
        "mobileAmount": mobileAmount,
        "amountToReceive": amountToReceive,
        "agentNumber": agentNumber,
        "mobileOperator": mobileOperator,
        "uid": auth!.currentUser!.uid,
      });
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }
}
