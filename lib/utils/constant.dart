import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const kMainColor = Color(0xff004d99);

const style1 = TextStyle(
    fontSize: 11, color: Colors.blueGrey, fontWeight: FontWeight.bold
);

const padding1 = EdgeInsets.only(top: 25.0, bottom: 10);

const headerTitle = TextStyle(
    fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold
);

CollectionReference cryptoToMobileRef = FirebaseFirestore.instance.collection("cryptoToMobile");
CollectionReference mobileToCryptoRef = FirebaseFirestore.instance.collection("mobileToCrypto");
CollectionReference cryptoToCryptoRef = FirebaseFirestore.instance.collection("cryptoToCrypto");