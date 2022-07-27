import 'package:expoin/providers/mobile_to_crypto_provider/mobile_to_crypto_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileToCryptoComponents extends StatefulWidget {
  const MobileToCryptoComponents({Key? key}) : super(key: key);

  @override
  State<MobileToCryptoComponents> createState() => _MobileToCryptoComponentsState();
}

class _MobileToCryptoComponentsState extends State<MobileToCryptoComponents> {
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }
  final _formKey = GlobalKey<FormState>();
  String? cryptoType;
  String? mobileOperator;
  TextEditingController _mobileAmountController = TextEditingController();
  TextEditingController _amountToReceiveController = TextEditingController();
  TextEditingController _cryptoNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 45.0),
                    child: Text("Mobile - Crypto", style: headerTitle,),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 540,
              width: width,
              decoration: containerBodyDecoration(
                color: Color(0xfff7f7f7),
                topLeftRadius: 25,
                topRightRadius: 25,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: padding1,
                    child: Text("Opérateur mobile", style: style1,),
                  ),
                  DropdownButtonFormField(
                    value: mobileOperator,
                    decoration: textFieldDecoration(hintText: ListHelper().listMobileOperator[0]),
                    items: ListHelper().listMobileOperator.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        mobileOperator = value.toString();
                      });
                    },
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Montant en mobile", style: style1,),
                  ),
                  TextFormField(
                    controller: _mobileAmountController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value) => _mobileAmountController.text,
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Type de crypto", style: style1,),
                  ),
                  DropdownButtonFormField(
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
                    child: Text("Montant à recevoir", style: style1,),
                  ),
                  TextFormField(
                    controller: _amountToReceiveController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value) => _amountToReceiveController.text,
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Numéro de crypto", style: style1,),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _cryptoNumberController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value) => _cryptoNumberController.text,
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    text: "PROCEDER",
                    onPressed: (){
                      if(!_formKey.currentState!.validate()) return;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Validation2Screen(
                        cryptoType: cryptoType,
                        mobileOperator: mobileOperator,
                        mobileAmount: _mobileAmountController.text.toString(),
                        amountToReceive: _amountToReceiveController.text.toString(),
                        cryptoNumber: _cryptoNumberController.text.toString(),
                      )));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
