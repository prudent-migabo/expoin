import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class PhoneNumbersRepository {

  Stream<PhoneNumbersModel> getNumbers (){
    return configurationRef.doc('phoneNumbers').snapshots().map((doc) => PhoneNumbersModel.fromMap(doc));
  }
}