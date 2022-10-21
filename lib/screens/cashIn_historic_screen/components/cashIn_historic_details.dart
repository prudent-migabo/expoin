import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class CashInHistoricDetails extends StatelessWidget {
  String? userName;
  String? cryptoType;
  String? amountToSend;
  String? hashNumber;
  String? mobileType;
  String? transactionContent;

  CashInHistoricDetails({
    this.userName,
    this.cryptoType,
    this.amountToSend,
    this.hashNumber,
    this.mobileType,
    this.transactionContent,
  });

  static const String routeName = "/CashInMoreDetails";

  static Route route (){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CashInHistoricDetails(),
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
            Text('\$ envoyé : $amountToSend', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Numero hash : $hashNumber', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text('Type de Mobile money : $mobileType', style: kFontStyleDetailsTrans,),
            kSizedBox10,
            Text("Message de confirmation :\n$transactionContent",
              style: kFontStyleDetailsTrans,),
          ],
        ),
      ),
    );
  }

}
