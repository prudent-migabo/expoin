import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class CashOutTransactionScreen extends StatefulWidget {
  const CashOutTransactionScreen({Key? key}) : super(key: key);

  @override
  State<CashOutTransactionScreen> createState() => _CashOutTransactionScreenState();
}

class _CashOutTransactionScreenState extends State<CashOutTransactionScreen> {
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
    cryptoType = MesPiecesBloc.selectedCryptoName;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CashInCalculationProvider>().initializer();
    });
  }


  final _formKey = GlobalKey<FormState>();
  String? cryptoType;
  final TextEditingController _amountToSendController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  String? dialCodeDigits = "+243";

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CashOutProvider>().state;

    if(state.cashOutStatus == CashOutStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _amountToSendController.clear();
        _mobileNumberController.clear();
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding1.copyWith(top: 0, bottom: 10),
          child: const Text("Type de crypto :", style: style1,),
        ),
        DropdownButtonFormField(
          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[600]),
          value: cryptoType,
          decoration: transactionFieldDecor(hintText: MesPiecesBloc.selectedCryptoName),
          items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
          onChanged: (value) {
            setState(() {
              cryptoType = value.toString();
            });
           context.read<HashNumberProvider>().saveCashOutCryptoType(cryptoType!);
            saveFieldsData();
          },
        ),

        const Padding(
          padding: padding1,
          child: Text("Montant à envoyer :", style: style1,),
        ),
        Form(
          key: _formKey,
          child: Builder(
            builder: (context) {
              var rate1 = context.watch<CashOutRateModel>().rate1;
              var rate2 = context.watch<CashOutRateModel>().rate2;
              var rate3 = context.watch<CashOutRateModel>().rate3;
              var rate4 = context.watch<CashOutRateModel>().rate4;
              var rate5 = context.watch<CashOutRateModel>().rate5;
              var rate6 = context.watch<CashOutRateModel>().rate6;
              var rate7 = context.watch<CashOutRateModel>().rate7;
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _amountToSendController,
                      decoration: transactionFieldDecor(hintText: "Saisissez ici"),
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
                            rate5: rate5,
                            rate6: rate6,
                            rate7: rate7,
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
                        Text('à recevoir :'),
                        SizedBox(height: 10,),
                        Text("${context.watch<CashOutCalculationProvider>().result.toString()}\$", style: textStyleBold,),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),

        Padding(
          padding: padding1,
          child: Text("Numéro mobile money :", style: style1,),
        ),

        TextFormField(
          style: const TextStyle(fontSize: 14),
          controller: _mobileNumberController,
          keyboardType: TextInputType.phone,
          validator: (value) => value!.isEmpty
              ? 'Une value null ne peut être enregistrée'
              : value.length < 8 ? "Numéro trop court, il doit etre d'au moins 8 chiffres"
              : value.length > 9 ? "Numéro trop long, il doit etre au plus 9 chiffres"
              : null,
          decoration: textFieldAuthDecoration(
            hintText: "Saisissez ici",
            prefixIcon: CountryCodePicker(
              onChanged: (country) {
                setState(() => dialCodeDigits = country.dialCode);
              },
              initialSelection: "CD",
              showCountryOnly: true,
              showOnlyCountryWhenClosed: false,
              favorite: ["+256", "UG", "+243", "CD"],
            ),
          ),
            onChanged: (value) => saveFieldsData(),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  void saveFieldsData(){
    context.read<SaveCashOutDetailsController>().saveCashOutDetails(
      CashOutModel(
          cryptoType: cryptoType,
          amountToSend: _amountToSendController.text,
          phoneMobileNumber: dialCodeDigits! + _mobileNumberController.text.trim(),
          transactionID: ''),
    );
  }

}
