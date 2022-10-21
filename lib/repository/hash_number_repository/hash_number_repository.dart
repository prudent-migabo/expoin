import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class HashNumberRepository {

  Stream<HashNumberModel> getHashNumber(){
    return configurationRef.doc('hashNumber').snapshots().map((doc) => HashNumberModel.fromMap(doc));
  }

}