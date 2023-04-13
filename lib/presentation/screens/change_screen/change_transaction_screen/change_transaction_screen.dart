import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class ChangeTransactionScreen extends StatefulWidget {
  const ChangeTransactionScreen({Key? key}) : super(key: key);

  @override
  State<ChangeTransactionScreen> createState() => _ChangeTransactionScreenState();
}

class _ChangeTransactionScreenState extends State<ChangeTransactionScreen> {
  @override
  void initState() {
    super.initState();
    cryptoTypeToSend = MesPiecesBloc.selectedCryptoName;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ChangeCalculationProvider>().initializer();
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }


  final _formKey = GlobalKey<FormState>();
  String? cryptoTypeToSend;
  String? cryptoTypeToReceive;
  final TextEditingController _cryptoToSendController = TextEditingController();
  final TextEditingController _hashNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangeProvider>().state;

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
            child: const Text("Type de crypto à envoyer :", style: style1,),
          ),
          DropdownButtonFormField(
            value: cryptoTypeToSend,
            decoration: transactionFieldDecor(hintText: 'Selectionnez'),
            items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
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
            decoration: transactionFieldDecor(hintText: 'Selectionnez'),
            items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
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
          Builder(
            builder: (context) {
              var rate1 = context.watch<ChangeRateModel>().rate1;
              var rate2 = context.watch<ChangeRateModel>().rate2;
              var rate3 = context.watch<ChangeRateModel>().rate3;
              var rate4 = context.watch<ChangeRateModel>().rate4;
              var rate5 = context.watch<ChangeRateModel>().rate5;
              var rate6 = context.watch<ChangeRateModel>().rate6;
              var rate7 = context.watch<ChangeRateModel>().rate7;
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _cryptoToSendController,
                      decoration: transactionFieldDecor(hintText: "Saisissez ici"),
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
                            rate5: rate5,
                            rate6: rate6,
                            rate7: rate7,
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
                        Text("${context.watch<ChangeCalculationProvider>().result.toString()}\$", style: textStyleBold,),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),

          Padding(
            padding: padding1,
            child: Text("Wallet à recevoir :", style: style1,),
          ),

          TextFormField(
            controller: _hashNumberController,
            decoration: transactionFieldDecor(hintText: "Saisissez ici"),
            validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
            onChanged: (value) => saveFieldsData(),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Future saveFieldsData() async{
    await context.read<SaveChangeDetailsController>().saveChangeDetails(
        ChangeModel(
            cryptoTypeToSend: cryptoTypeToSend ?? '',
            cryptoTypeToReceive: cryptoTypeToReceive ?? '',
            cryptoAmountToSend: _cryptoToSendController.text,
            hashNumber: _hashNumberController.text,
            transactionMessage: '')
    );
  }

}
