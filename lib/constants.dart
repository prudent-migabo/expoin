import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

CollectionReference userRef = FirebaseFirestore.instance.collection('users');
CollectionReference ratesRef = FirebaseFirestore.instance.collection('rates-commissions');
CollectionReference imageRef = FirebaseFirestore.instance.collection('imagesUrl');
CollectionReference configurationRef = FirebaseFirestore.instance.collection('configurations');
CollectionReference transactionRef = FirebaseFirestore.instance.collection('transactions');
CollectionReference boutiqueRef = FirebaseFirestore.instance.collection('boutique');
CollectionReference boutiquesImagesRef = FirebaseFirestore.instance.collection('boutiquesImages');
CollectionReference userProfileImageRef = FirebaseFirestore.instance.collection('users-profile-images');


Color customBlue = Color(0xffd1d7ee);
Color customYellow = Color(0xfff9e8cb);
FontWeight bold = FontWeight.bold;
SizedBox transactionDetailsSpacer = const SizedBox(height: 10,);

EdgeInsets mainPadding = const EdgeInsets.symmetric(vertical: 30, horizontal: 20);const String noNetworkMessage = 'Pas de connexion internet';
TextStyle sliverAppbarTitle = GoogleFonts.dmSans(
    fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold
);

const style1 = TextStyle(
    fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold
);

const padding1 = EdgeInsets.only(top: 25.0, bottom: 10);

const textStyleBold = TextStyle(fontWeight: FontWeight.bold);

