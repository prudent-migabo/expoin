import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class BoutiqueRepository {
  String cryptoWallet = 'cryptoWallet';
  String mobileMoneyWallet = 'mobileMoneyWallet';
  
  Stream<CryptoModel> getBoutiqueCryptoModel (String boutiqueID, String boutiqueName){
    return boutiqueRef.doc(boutiqueID).collection(cryptoWallet).doc(boutiqueName).snapshots().map((event) => CryptoModel.fromMap(event));
  }

  List<BoutiqueModel> listBoutiques (QuerySnapshot querySnapshot){
    return querySnapshot.docs.map((e) => BoutiqueModel.fromMap(e)).toList();
  }
  Stream<List<BoutiqueModel>> getBoutiqueListModel (){
    return boutiqueRef.snapshots().map(listBoutiques);
  }

  Future getListBoutique () async{
    Map resultData;
    var v = await boutiqueRef.get();
    v.docs.forEach((element) {
      resultData = element.data() as Map;
      MesPiecesBloc.boutiquesInfo = resultData;
      print('1111111111111111111111111111111111111111111111111111111111111111111111 ${MesPiecesBloc.boutiquesInfo}');
    });
 //   print('1111111111111111111111111111111111111111111111111111111111111111111111 $resultData');
  }
}