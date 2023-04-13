import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class MobileRepository {
  static String mobileMoneyWallet = 'mobileMoneyWallet';

  Stream <MobileMoneyModel> getMobileModel ({String? boutiqueID, String? mobileName}){
    return boutiqueRef.doc(boutiqueID).collection(mobileMoneyWallet).doc(mobileName).snapshots().map((event) => MobileMoneyModel.fromMap(event));
  }

}