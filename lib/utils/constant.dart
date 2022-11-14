import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const kMainColor = Color(0xff004d99);

const kMainWhiteColor = Color(0xfff7f7f7);

const style1 = TextStyle(
    fontSize: 11, color: Colors.blueGrey, fontWeight: FontWeight.bold
);

const padding1 = EdgeInsets.only(top: 25.0, bottom: 10);

const headerTitle = TextStyle(
    fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold
);

const fontColor1 = TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold
);

const fontColor2 = TextStyle(
    color: Colors.white
);

const fontSizeTile = TextStyle(
  fontSize: 12
);

CollectionReference userRef = FirebaseFirestore.instance.collection("users");
CollectionReference cashOutRef = FirebaseFirestore.instance.collection("cashOut");
CollectionReference cashInRef = FirebaseFirestore.instance.collection("cashIn");
CollectionReference changeRef = FirebaseFirestore.instance.collection("change");
CollectionReference ratesRef = FirebaseFirestore.instance.collection('rates-commissions');
CollectionReference imageRef = FirebaseFirestore.instance.collection('imagesUrl');
CollectionReference configurationRef = FirebaseFirestore.instance.collection('configurations');


const calculatorStyle = TextStyle(fontSize: 12, color: Colors.blueGrey, fontWeight: FontWeight.bold);
const kTextBold = TextStyle(fontWeight: FontWeight.bold);
const kSizedBox10 = SizedBox(height: 10,);
const kFontStyleDetailsTrans = TextStyle(fontWeight: FontWeight.bold, fontSize: 17,);
Color? kColorCopiableText = Colors.blue[700];


