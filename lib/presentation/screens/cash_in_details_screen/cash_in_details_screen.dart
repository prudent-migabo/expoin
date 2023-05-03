import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/presentation.dart';

class CashInDetailsScreen extends StatelessWidget {
  CashInDetailsScreen(
      {Key? key,
      this.name,
      this.mobileType,
      this.cryptoType,
      this.hashNumber,
      this.amountToSend,
      this.amountToReceive,
      this.status,
        this.transactionID,
        this.boutiqueName,
      })
      : super(key: key);

  String? name;
  String? amountToSend;
  String? hashNumber;
  String? amountToReceive;
  String? cryptoType;
  bool? status;
  String? mobileType;
  String? transactionID;
  String? boutiqueName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: mainPadding,
        child: Column(
          children: [
            CustomAppbar(
              title: 'Details achat',
            ),
            SizedBox(height: 10,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: customBlue,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    RowInfos(
                      title: 'Nom',
                      value: name!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: '\$ envoyé',
                      value: amountToSend!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: '\$ à recevoir',
                      value: amountToReceive!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Type de crypto',
                      value: cryptoType!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Etat',
                      value: status == true ? 'En attente' : 'Approuvé',
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Operateur mobile',
                      value: mobileType!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'ID de la transaction',
                      value: transactionID!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Nom de la boutique',
                      value: boutiqueName!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
