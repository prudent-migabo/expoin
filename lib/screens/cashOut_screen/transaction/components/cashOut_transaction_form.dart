import 'package:expoin/screens/screens.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';

class CashOutTransactionForm extends StatefulWidget {
  const CashOutTransactionForm({Key? key}) : super(key: key);

  @override
  State<CashOutTransactionForm> createState() => _CashOutTransactionFormState();
}

class _CashOutTransactionFormState extends State<CashOutTransactionForm> {
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
  String? cryptoType;
  String? mobileOperator;
  TextEditingController _amountToReceiveController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding1.copyWith(top: 0, bottom: 10),
          child: Text("Type de crypto", style: style1,),
        ),
        DropdownButtonFormField(
          key: _key1,
          value: cryptoType,
          decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
          items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
          onChanged: (value) {
            setState(() {
              cryptoType = value.toString();
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
                controller: _amountToReceiveController,
                decoration: textFieldDecoration(hintText: ""),
                validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value) => _amountToReceiveController.text,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Crypto à envoyer'),
                  SizedBox(height: 10,),
                  Text("00003", style: kTextBold,),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: padding1,
          child: Text("Numéro mobile money", style: style1,),
        ),

        TextFormField(
          keyboardType: TextInputType.number,
          controller: _mobileNumberController,
          decoration: textFieldDecoration(hintText: ""),
          validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
          onChanged: (value) => _mobileNumberController.text,
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}

