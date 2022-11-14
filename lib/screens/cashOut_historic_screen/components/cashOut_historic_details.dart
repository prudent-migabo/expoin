import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CashOutHistoricDetails extends StatelessWidget {
  String? userName;
  String? cryptoType;
  String? cryptoAmountToSend;
  String? amountToReceive;
  String? transactionMessage;
  String? phoneNumber;

  CashOutHistoricDetails({
    this.userName,
    this.cryptoType,
    this.cryptoAmountToSend,
    this.amountToReceive,
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
            SizedBox(height: 30,),
            RowForDetailsStyle(title: 'Nom', value: userName!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Type de crypto', value: cryptoType!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Montant envoyé', value: cryptoAmountToSend!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Montant à recevoir', value: amountToReceive!,),
            kSizedBox10,
            Row(
              children: [
                Text("Numero de telephone :", style: TextStyle(fontSize: 15)),
                SelectableText(' ${phoneNumber!}', style: kFontStyleDetailsTrans.copyWith(color: kColorCopiableText),),
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