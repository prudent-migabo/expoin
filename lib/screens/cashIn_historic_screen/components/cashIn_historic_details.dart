import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class CashInHistoricDetails extends StatelessWidget {
  String? userName;
  String? cryptoType;
  String? amountToSend;
  String? amountToReceive;
  String? hashNumber;
  String? mobileType;
  String? transactionContent;

  CashInHistoricDetails({
    this.userName,
    this.cryptoType,
    this.amountToSend,
    this.amountToReceive,
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
            SizedBox(height: 30,),
            RowForDetailsStyle(title: 'Nom', value: userName!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Type de crypto', value: cryptoType!,),
            kSizedBox10,
            RowForDetailsStyle(title: 'Montant envoyé', value: amountToSend!,),
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
            RowForDetailsStyle(title: 'Type de Mobile money', value: mobileType!,),
            kSizedBox10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${'Message de confirmation'} :", style: TextStyle(fontSize: 15)),
                SizedBox(height: 8,),
                SelectableText(transactionContent!, style: kFontStyleDetailsTrans.copyWith(color: kColorCopiableText),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
