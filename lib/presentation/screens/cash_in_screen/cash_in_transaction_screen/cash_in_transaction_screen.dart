import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class CashInTransactionScreen extends StatefulWidget {
  const CashInTransactionScreen({Key? key}) : super(key: key);

  @override
  State<CashInTransactionScreen> createState() => _CashInTransactionScreenState();
}

class _CashInTransactionScreenState extends State<CashInTransactionScreen> {

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
  String cryptoType = MesPiecesBloc.selectedCryptoName;
  String? mobileType;
  final TextEditingController _amountToSendController = TextEditingController();
  final TextEditingController _hashNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CashInProvider>().state;

    if(state.cashInStatus == CashInStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _amountToSendController.clear();
        _hashNumberController.clear();
      });
    }
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding1,
            child: Text("Type de crypto :", style: style1,),
          ),
          DropdownButtonFormField(
            style: GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[600]),
            value: cryptoType,
            decoration: transactionFieldDecor(hintText: MesPiecesBloc.selectedCryptoName),
            items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                cryptoType = value!;
              });
            },
          ),

          Padding(
            padding: padding1,
            child: Text("\$ à envoyer :", style: style1,),
          ),
          Builder(
            builder: (context) {
              var rate1 = context.watch<CashInRateModel>().rate1;
              var rate2 = context.watch<CashInRateModel>().rate2;
              var rate3 = context.watch<CashInRateModel>().rate3;
              var rate4 = context.watch<CashInRateModel>().rate4;
              var rate5 = context.watch<CashInRateModel>().rate5;
              var rate6 = context.watch<CashInRateModel>().rate6;
              var rate7 = context.watch<CashInRateModel>().rate7;
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _amountToSendController,
                      decoration: transactionFieldDecor(hintText: 'Saisissez ici'),
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
                            rate5: rate5,
                            rate6: rate6,
                            rate7: rate7,
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
                        Text("${context.watch<CashInCalculationProvider>().result.toString()}\$", style: textStyleBold,),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
          Padding(
            padding: padding1,
            child: Text("Wallet :", style: style1,),
          ),
          TextFormField(
            controller: _hashNumberController,
            decoration: transactionFieldDecor(hintText: 'Saisissez ici'),
            validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
            onChanged: (value) => saveFieldsData(),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  void saveFieldsData(){
    context.read<SaveCashInDetailsController>().saveCashInDetails(
      CashInModel(
          cryptoType: cryptoType,
          amountToSend: _amountToSendController.text,
          hashNumber: _hashNumberController.text,
          mobileType: '',
          transactionID: ''),
    );
  }

}