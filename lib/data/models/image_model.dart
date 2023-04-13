import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel{
  String imgUrl;
  String? date;
  String? docID;

//<editor-fold desc="Data Methods">

  ImageModel({
    required this.imgUrl,
    this.date,
    this.docID,
  });

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'date': DateTime.now(),
    };
  }

  factory ImageModel.fromMap(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data()! as Map;
    return ImageModel(
      imgUrl: data['imgUrl'] ?? '',
      docID: documentSnapshot.id,
    );
  }

//</editor-fold>
}