import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/presentation.dart';

class AccountConfigurationScreen extends StatelessWidget {
  static const String routeName = '/AccountConfigurationScreen';
  const AccountConfigurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            AuthHeader(text: 'Configuration de vos comptes'),
            SizedBox(height: 30,),
            Text("Dans la configuration de vos adresses wallet, vous allez fournir des adresses wallets pour les comptes que vous utilisez actuellement.", style: TextStyle(fontWeight: bold, fontSize: 15),),
            SizedBox(height: 30,),
            CustomButton(text: "Suivant", onPressed: (){
              Navigator.pushNamed(context, RegisterCryptoScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
