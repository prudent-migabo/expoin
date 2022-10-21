// import 'package:expoin/models/models.dart';
// import 'package:expoin/utils/utils.dart';
//
// class CalculatorRepository{
//  // Stream<RateModel>? a;
//   Map data = {};
//   String? documentID;
//   Future getRateValue (String docID) async{
//     await rateRef.doc(docID).get().then((value) {
//       data = value.data() as Map;
//       documentID = value.id;
//     });
//     return data;
//   }
//
//
//   Stream<CalculationModel> getRateValueDetail(){
//     Stream<CalculationModel> a = rateRef.doc("BNB").snapshots().map((doc) => CalculationModel.fromMap(doc));
//     a.listen((event) {
//       print("==============rate repository ${event.rate}================");
//     });
//     return a;
//   }
//
// }