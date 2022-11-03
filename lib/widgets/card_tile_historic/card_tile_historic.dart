import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CardTileHistoric extends StatelessWidget {
  CardTileHistoric({
    required this.userName,
    required this.amountToSend,
    required this.amountToReceive,
    required this.onPressed,
    required this.onLongPressed,
    required this.isPending,
  });

  VoidCallback onPressed;
  VoidCallback onLongPressed;
  String userName;
  String amountToSend;
  String amountToReceive;
  bool isPending;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 6),
      color: Colors.blueGrey[50],
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(userName, style: kTextBold,),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("A envoyé : $amountToSend\$", style: kTextBold),
              SizedBox(height: 5,),
              Text("Veut recevoir : $amountToReceive\$", style: kTextBold)
            ],
          ),
          trailing: RoundedCardTileTrans(
            text: isPending ? 'En attente' : 'Approuvé',
            color: isPending ? Colors.red.shade800 : Colors.green,
          ),
          onTap: onPressed,
          onLongPress: onLongPressed,
        ),
      ),
    );
  }
}