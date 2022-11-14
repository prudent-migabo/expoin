import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ChangeHistoricDetails extends StatelessWidget {
  String? userName;
  String? cryptoTypeToSend;
  String? cryptoTypeToReceive;
  String? cryptoAmountToSend;
  String? amountToReceive;
  String? hashNumber;
  String? transactionMessage;

  ChangeHistoricDetails({
    this.userName,
    this.cryptoTypeToSend,
    this.cryptoTypeToReceive,
    this.cryptoAmountToSend,
    this.amountToReceive,
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
            SizedBox(height: 30,),
            RowForDetailsStyle(title: 'Nom', value: userName!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Type de crypto envoyé', value: cryptoTypeToSend!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Type de crypto à recevoir', value: cryptoTypeToReceive!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Montant envoyé', value: cryptoAmountToSend!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Montant à recevoir', value: amountToReceive!,),
            kSizedBox10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Wallet :", style: TextStyle(fontSize: 15)),
                Expanded(child: SelectableText(' ${hashNumber!}', style: kFontStyleDetailsTrans.copyWith(color: kColorCopiableText),)),
              ],
            ),
            kSizedBox10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${'Message de confirmation'} :", style: TextStyle(fontSize: 15)),
                SizedBox(height: 8,),
                SelectableText(transactionMessage!, style: kFontStyleDetailsTrans.copyWith(color: kColorCopiableText),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}