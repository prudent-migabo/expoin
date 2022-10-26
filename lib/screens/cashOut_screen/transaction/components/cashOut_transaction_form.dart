import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CashOutCalculationProvider>().initializer();
    });
  }

  final GlobalKey<FormFieldState> _key1 = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();
  String? cryptoType;
  TextEditingController _amountToSendController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.read<CashOutProvider>().state;
    var rate1 = context.watch<CashOutRateModel>().rate1;
    var rate2 = context.watch<CashOutRateModel>().rate2;
    var rate3 = context.watch<CashOutRateModel>().rate3;
    var rate4 = context.watch<CashOutRateModel>().rate4;

    if(state.cashOutStatus == CashOutStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _amountToSendController.clear();
        _mobileNumberController.clear();
      });
    }

    return Form(
      key: _formKey,
      child: Column(
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
            child: Text("Montant à envoyer :", style: style1,),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountToSendController,
                  decoration: textFieldDecoration(hintText: "Saisissez ici"),
                  validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                  onChanged: (value) {
                    if(value.isNotEmpty){
                      context.read<CashOutCalculationProvider>().cashOutCalculation(
                        context: context,
                        value: _amountToSendController.text,
                        rate1: rate1,
                        rate2: rate2,
                        rate3: rate3,
                        rate4: rate4,
                      );
                    } else{
                      context.read<CashOutCalculationProvider>().initializer();
                    }
                    saveFieldsData();
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('\$ à recevoir :'),
                    SizedBox(height: 10,),
                    Text(context.watch<CashOutCalculationProvider>().result.toString(), style: kTextBold,),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: padding1,
            child: Text("Numéro mobile money :", style: style1,),
          ),

          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _mobileNumberController,
            decoration: textFieldDecoration(hintText: "Saisissez ici"),
            validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
            onChanged: (value) {
              saveFieldsData();
            },
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  void saveFieldsData(){
    context.read<SaveCashOutDetailsController>().saveCashOutDetails(
      CashOutModel(
          cryptoType: cryptoType!,
          amountToSend: _amountToSendController.text,
          phoneMobileNumber: _mobileNumberController.text,
          transactionID: '')
    );
  }

}

