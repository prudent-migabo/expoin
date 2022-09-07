import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const kMainColor = Color(0xff004d99);

const kMainWhiteColor = Color(0xfff7f7f7);

const style1 = TextStyle(
    fontSize: 11, color: Colors.blueGrey, fontWeight: FontWeight.bold
);

const padding1 = EdgeInsets.only(top: 25.0, bottom: 10);

const headerTitle = TextStyle(
    fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
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

const calculatorStyle = TextStyle(fontSize: 12, color: Colors.blueGrey, fontWeight: FontWeight.bold);

const kTextBold = TextStyle(fontWeight: FontWeight.bold);

CollectionReference userRef = FirebaseFirestore.instance.collection("users");
CollectionReference cryptoToMobileRef = FirebaseFirestore.instance.collection("cryptoToMobile");
CollectionReference mobileToCryptoRef = FirebaseFirestore.instance.collection("mobileToCrypto");
CollectionReference cryptoToCryptoRef = FirebaseFirestore.instance.collection("cryptoToCrypto");

CollectionReference cashOutRef = FirebaseFirestore.instance.collection("cashOut");
CollectionReference cashInRef = FirebaseFirestore.instance.collection("cashIn");
CollectionReference changeRef = FirebaseFirestore.instance.collection("change");

CollectionReference rateRef = FirebaseFirestore.instance.collection("exchange");
