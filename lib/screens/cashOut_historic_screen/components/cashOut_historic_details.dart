import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CashOutHistoricDetails extends StatelessWidget {
  String? userName;
  String? cryptoType;
  String? cryptoAmountToSend;
  String? transactionMessage;
  String? phoneNumber;

  CashOutHistoricDetails({
    this.userName,
    this.cryptoType,
    this.cryptoAmountToSend,
    this.transactionMessage,
    this.phoneNumber,
  });

  static const String routeName = "/CashOutMoreDetails";

  static Route route (){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CashOutHistoricDetails(),
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
            Text('Type de crypto : $cryptoType', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Crypto envoyé : $cryptoAmountToSend', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Numero de telephone : $phoneNumber', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text("Message de confirmation : \n$transactionMessage",
              style: kFontStyleDetailsTrans,),
          ],
        ),
      ),
    );
  }

}