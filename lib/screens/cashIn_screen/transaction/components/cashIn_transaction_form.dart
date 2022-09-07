import 'package:expoin/screens/screens.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';

class CashInTransactionForm extends StatefulWidget {
  const CashInTransactionForm({Key? key}) : super(key: key);

  @override
  State<CashInTransactionForm> createState() => _CashInTransactionFormState();
}

class _CashInTransactionFormState extends State<CashInTransactionForm> {
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
  TextEditingController _amountToSendController = TextEditingController();
  TextEditingController _hashNumberController = TextEditingController();

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
          child: Text("\$ à envoyer", style: style1,),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountToSendController,
                decoration: textFieldDecoration(hintText: ""),
                validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value) => _amountToSendController.text,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('A recevoir'),
                  SizedBox(height: 10,),
                  Text("00003", style: kTextBold,),
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
        SizedBox(height: 10,),
        // CustomButton(
        //   text: "PROCEDER",
        //   onPressed: (){
        //     if(!_formKey.currentState!.validate()) return;
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=> CashInValidationScreen(
        //       cryptoType: cryptoType,
        //       mobileOperator: mobileOperator,
        //       mobileAmount: _cryptoTypeController.text.toString(),
        //       amountToReceive: _amountToSendController.text.toString(),
        //       cryptoNumber: _hashNumberController.text.toString(),
        //     )));
        //   },
        // ),
      ],
    );
  }
}

