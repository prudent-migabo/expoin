import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/presentation.dart';

class ChangeDetailsScreen extends StatelessWidget {
  ChangeDetailsScreen(
      {Key? key,
        this.name,
        this.hashNumber,
        this.amountToSend,
        this.amountToReceive,
        this.cryptoTypeToReceive,
        this.cryptoTypeToSend,
        this.status,
        this.transactionID})
      : super(key: key);

  String? name;
  String? amountToSend;
  String? amountToReceive;
  String? cryptoTypeToSend;
  String? cryptoTypeToReceive;
  String? hashNumber;
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
              title: 'Details change',
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
                      title: 'Crypto à envoyer',
                      value: cryptoTypeToSend!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Crypto à recevoir',
                      value: cryptoTypeToReceive!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Montant à envoyer',
                      value: amountToSend!,
                    ),
                    transactionDetailsSpacer,
                    RowInfos(
                      title: 'Montant à recevoir',
                      value: amountToReceive!,
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
