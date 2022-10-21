import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ChangeHistoricDetails extends StatelessWidget {
  String? userName;
  String? cryptoTypeToSend;
  String? cryptoTypeToReceive;
  String? cryptoAmountToSend;
  String? hashNumber;
  String? transactionMessage;

  ChangeHistoricDetails({
    this.userName,
    this.cryptoTypeToSend,
    this.cryptoTypeToReceive,
    this.cryptoAmountToSend,
    this.hashNumber,
    this.transactionMessage,
  });

  static const String routeName = "/ChangeMoreDetails";

  static Route route (){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChangeHistoricDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            // Text('Details', style: TextStyle(color: kMainColor, fontWeight: kBold, fontSize: 17),),
            SizedBox(height: 15,),
            Text('Nom : $userName', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Type de crypto envoyé : $cryptoTypeToSend', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Type de crypto à recevoir : $cryptoTypeToReceive', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Montant à envoyer : $cryptoAmountToSend', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('HASH: $hashNumber', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text("Message de confirmation : \n$transactionMessage",
              style: kFontStyleDetailsTrans,),
          ],
        ),
      ),
    );
  }

}