import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';

class ImagesRepository{

  List<ImageModel> listImages(QuerySnapshot querySnapshot){
    return querySnapshot.docs.map((docs) => ImageModel.fromMap(docs)).toList();
  }

  Stream<List<ImageModel>> getListImages (){
    return imageRef.snapshots().map(listImages);
  }



}