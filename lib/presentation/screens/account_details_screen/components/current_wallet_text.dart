import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';

class CurrentWalletText extends StatelessWidget {
   CurrentWalletText({Key? key, required this.cryptoName}) : super(key: key);
  InformationRepository repository = InformationRepository();

  String cryptoName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WalletAddressModel>(
        stream: repository.getWalletAddress(cryptoName),
        builder: (context, snapshot){
          WalletAddressModel? walletAddressModel = snapshot.data;
          if(!snapshot.hasData){
            return Row(
              children: [
                Text('Actuelle adresse wallet : ', style: TextStyle(fontWeight: bold),),
                Text('.........'),
              ],
            );
          } else if (snapshot.hasError){
            errorDialog(context, content: snapshot.error.toString());
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('Actuelle adresse wallet : ', style: TextStyle(fontWeight: bold),)),
              Expanded(child: Text(walletAddressModel!.walletAddress!, style: TextStyle(fontWeight: bold, color: Theme.of(context).colorScheme.primary),)),
            ],
          );
        });
  }
}
