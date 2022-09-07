import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CryptoToCryptoRepository {
  CryptoToCryptoRepository({
    this.auth,
  });

  FirebaseAuth? auth;

  Future<void> addCryptoToCrypto(CryptoToCryptoModel cryptoToCryptoModel) async {
    try {
      await cryptoToCryptoRef.add(cryptoToCryptoModel.toMap());
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }
}
