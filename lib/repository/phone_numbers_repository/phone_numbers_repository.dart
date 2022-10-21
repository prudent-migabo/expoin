import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class PhoneNumbersRepository {

  Stream<PhoneNumbersModel> getNumbers (){
    return configurationRef.doc('phoneNumbers').snapshots().map((doc) => PhoneNumbersModel.fromMap(doc));
  }

}