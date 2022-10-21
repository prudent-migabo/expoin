import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/utils/utils.dart';

class ImagesRepository{

  List<ImageModel> listImages(QuerySnapshot querySnapshot){
    return querySnapshot.docs.map((docs) => ImageModel.fromMap(docs)).toList();
  }

  Stream<List<ImageModel>> getListImages (){
    return imageRef.orderBy('date', descending: true).snapshots().map(listImages);
  }

}