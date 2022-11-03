import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class HashNumberRepository {

  Stream<HashNumberModel> getHashNumber(String docID){
    return configurationRef.doc('hashNumbers').collection('hashNumbers').doc(docID).snapshots().map((doc) => HashNumberModel.fromMap(doc));
  }

}