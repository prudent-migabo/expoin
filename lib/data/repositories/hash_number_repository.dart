import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class HashNumberRepository {
  String hashNumbers = 'hashNumbers';

  Stream<HashNumberModel> getHashNumber(String cryptoName) {
    return configurationRef
        .doc(hashNumbers)
        .collection(hashNumbers)
        .doc(cryptoName)
        .snapshots()
        .map((doc) => HashNumberModel.fromMap(doc));
  }
}
