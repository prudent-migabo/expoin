import 'package:expoin/screens/screens.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';

class ChangeTransactionForm extends StatefulWidget {
  const ChangeTransactionForm({Key? key}) : super(key: key);

  @override
  State<ChangeTransactionForm> createState() => _ChangeTransactionFormState();
}

class _ChangeTransactionFormState extends State<ChangeTransactionForm> {
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _key1 = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _key2 = GlobalKey<FormFieldState>();
  String? cryptoTypeToSend;
  String? cryptoTypeToReceive;
  TextEditingController _cryptoToSendController = TextEditingController();
  TextEditingController _hashNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding1.copyWith(top: 0, bottom: 10),
          child: Text("Type de crypto à envoyer", style: style1,),
        ),
        DropdownButtonFormField(
          key: _key1,
          value: cryptoTypeToSend,
          decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
          items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
          onChanged: (value) {
            setState(() {
              cryptoTypeToSend = value.toString();
            });
          },
        ),

        Padding(
          padding: padding1,
          child: Text("Type de crypto à recevoir", style: style1,),
        ),
        DropdownButtonFormField(
          key: _key2,
          value: cryptoTypeToReceive,
          decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
          items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
          onChanged: (value) {
            setState(() {
              cryptoTypeToReceive = value.toString();
            });
          },
        ),

        Padding(
          padding: padding1,
          child: Text("\$ à recevoir", style: style1,),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _cryptoToSendController,
                decoration: textFieldDecoration(hintText: ""),
                validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value) => _cryptoToSendController.text,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Crypto à envoyer'),
                  SizedBox(height: 10,),
                  Text("0.0003", style: kTextBold,),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: padding1,
          child: Text("Numéro Hash", style: style1,),
        ),

        TextFormField(
          keyboardType: TextInputType.number,
          controller: _hashNumberController,
          decoration: textFieldDecoration(hintText: ""),
          validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
          onChanged: (value) => _hashNumberController.text,
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}

