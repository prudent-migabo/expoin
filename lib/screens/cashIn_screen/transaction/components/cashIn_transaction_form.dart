import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CashInCalculationProvider>().initializer();
    });
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _key1 = GlobalKey<FormFieldState>();
  String? cryptoType;
  String? mobileType;
  TextEditingController _amountToSendController = TextEditingController();
  TextEditingController _hashNumberController = TextEditingController();
  // double displayResult = 0.0;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CashInProvider>().state;
    var rate1 = context.watch<CashInRateModel>().rate1;
    var rate2 = context.watch<CashInRateModel>().rate2;
    var rate3 = context.watch<CashInRateModel>().rate3;
    var rate4 = context.watch<CashInRateModel>().rate4;

    if(state.cashInStatus == CashInStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _amountToSendController.clear();
        _hashNumberController.clear();
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding1.copyWith(top: 0, bottom: 10),
          child: Text("Type de crypto :", style: style1,),
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
            saveFieldsData();
          },
        ),

        Padding(
          padding: padding1,
          child: Text("\$ à envoyer :", style: style1,),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountToSendController,
                decoration: textFieldDecoration(hintText: "Saisissez ici"),
                validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value)  async{
                  if(value.isNotEmpty){
                    await context.read<CashInCalculationProvider>().cashInCalculation(
                      context : context,
                      value: _amountToSendController.text,
                      rate1: rate1,
                      rate2: rate2,
                      rate3: rate3,
                      rate4: rate4,
                    );
                  } else{
                    context.read<CashInCalculationProvider>().initializer();
                  }
                  saveFieldsData();
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('à recevoir :'),
                  SizedBox(height: 10,),
                  Text("${context.watch<CashInCalculationProvider>().result.toString()} \$", style: kTextBold,),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: padding1,
          child: Text("Wallet :", style: style1,),
        ),

        TextFormField(
          controller: _hashNumberController,
          decoration: textFieldDecoration(hintText: "Saisissez ici"),
          validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
          onChanged: (value) {
            saveFieldsData();
          },
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  void saveFieldsData(){
    context.read<SaveCashInDetailsController>().saveCashInDetails(
        CashInModel(
            cryptoType: cryptoType!,
            amountToSend: _amountToSendController.text,
            hashNumber: _hashNumberController.text,
            mobileType: '',
            transactionID: ''));
  }

}

