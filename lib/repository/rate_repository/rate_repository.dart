import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class RateRepository{
 // Stream<RateModel>? a;
  Map data = {};
  String? documentID;
  Future getRateValue (String docID) async{
    await rateRef.doc(docID).get().then((value) {
      data = value.data() as Map;
      documentID = value.id;
    });
  //  print("-----------------------rate repository$data, ${data["docID"]}, $documentID-----------------------");
    return data;
  }

  // Future getValue(String docID) async {
  //   String rate;
  //   var snapshot = await rateRef.get();
  //   for(var doc in snapshot.docs){
  //     rate = doc.data()!;
  //   }
  // }

  //  Stream<RateModel> getRateValueDetail(String docID){
  //   return rateRef.doc(docID).snapshots().map((doc) => RateModel.fromMap(doc));
  // }

  Stream<RateModel> getRateValueDetail(){
    Stream<RateModel> a = rateRef.doc("BNB").snapshots().map((doc) => RateModel.fromMap(doc));
    a.listen((event) {
      print("==============rate repository ${event.rate}================");
    });
    return a;
  }

}