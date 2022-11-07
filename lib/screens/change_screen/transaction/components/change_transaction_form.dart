import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ChangeCalculationProvider>().initializer();
    });
  }

  final _formKey = GlobalKey<FormState>();
  String? cryptoTypeToSend;
  String? cryptoTypeToReceive;
  TextEditingController _cryptoToSendController = TextEditingController();
  TextEditingController _hashNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangeProvider>().state;
    var rate1 = context.watch<ChangeRateModel>().rate1;
    var rate2 = context.watch<ChangeRateModel>().rate2;
    var rate3 = context.watch<ChangeRateModel>().rate3;
    var rate4 = context.watch<ChangeRateModel>().rate4;

    if(state.changeStatus == ChangeStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _hashNumberController.clear();
        _cryptoToSendController.clear();
      });
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding1.copyWith(top: 0, bottom: 10),
            child: Text("Type de crypto à envoyer :", style: style1,),
          ),
          DropdownButtonFormField(
            value: cryptoTypeToSend,
            decoration: textFieldDecoration(hintText: 'Selectionnez'),
            items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                cryptoTypeToSend = value.toString();
              });
               context.read<HashNumberProvider>().saveChangeCryptoType(cryptoTypeToSend!);
              saveFieldsData();
            },
          ),

          Padding(
            padding: padding1,
            child: Text("Type de crypto à recevoir :", style: style1,),
          ),
          DropdownButtonFormField(
            value: cryptoTypeToReceive,
            decoration: textFieldDecoration(hintText: 'Selectionnez'),
            items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                cryptoTypeToReceive = value.toString();
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
                  controller: _cryptoToSendController,
                  decoration: textFieldDecoration(hintText: "Saisissez ici"),
                  validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                  onChanged: (value) {
                    if(value.isNotEmpty){
                      context.read<ChangeCalculationProvider>().changeCalculation(
                        context: context,
                        value: _cryptoToSendController.text,
                        rate1: rate1,
                        rate2: rate2,
                        rate3: rate3,
                        rate4: rate4,
                      );
                    } else{
                      context.read<ChangeCalculationProvider>().initializer();
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
                    Text("${context.watch<ChangeCalculationProvider>().result.toString()}\$", style: kTextBold,),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: padding1,
            child: Text("Wallet à recevoir :", style: style1,),
          ),

          TextFormField(
            controller: _hashNumberController,
            decoration: textFieldDecoration(hintText: "Saisissez ici"),
            validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
            onChanged: (value) {
              saveFieldsData();
            },
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Future saveFieldsData() async{
   await context.read<SaveChangeDetailsController>().saveChangeDetails(
      ChangeModel(
          cryptoTypeToSend: cryptoTypeToSend!,
          cryptoTypeToReceive: cryptoTypeToReceive!,
          cryptoAmountToSend: _cryptoToSendController.text,
          hashNumber: _hashNumberController.text,
          transactionMessage: '')
    );
  }

}

