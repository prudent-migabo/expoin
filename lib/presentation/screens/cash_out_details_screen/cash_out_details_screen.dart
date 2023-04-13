import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/presentation.dart';

class CashOutDetailsScreen extends StatelessWidget {
  CashOutDetailsScreen(
      {Key? key,
        this.name,
        this.cryptoType,
        this.phoneNumber,
        this.amountToSend,
        this.amountToReceive,
        this.status,
        this.transactionID})
      : super(key: key);

  String? name;
  String? amountToSend;
  String? phoneNumber;
  String? amountToReceive;
  String? cryptoType;
  bool? status;
  String? transactionID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: mainPadding,
        child: Column(
          children: [
            CustomAppbar(
              title: 'Details vente',
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
                      title: 'Téléphone',
                      value: phoneNumber!,
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
                      title: 'ID de la transaction',
                      value: transactionID!,
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
