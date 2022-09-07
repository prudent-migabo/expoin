import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileToCryptoRepository {
  MobileToCryptoRepository({
    this.auth,
  });

  FirebaseAuth? auth;

  Future<void> addMobileToCrypto(MobileToCryptoModel mobileToCryptoModel) async {
    try {
      await mobileToCryptoRef.add(mobileToCryptoModel.toMap());
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: "Exception", message: e.toString(), plugin: "Exception/Plugin");
    }
  }
}
