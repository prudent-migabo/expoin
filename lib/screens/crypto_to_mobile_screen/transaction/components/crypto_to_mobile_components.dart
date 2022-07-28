import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoToMobileComponents extends StatefulWidget {
   CryptoToMobileComponents({Key? key}) : super(key: key);

  @override
  State<CryptoToMobileComponents> createState() => _CryptoToMobileComponentsState();
}

class _CryptoToMobileComponentsState extends State<CryptoToMobileComponents> {
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  String? cryptoType;
  TextEditingController _cryptoAmountController = TextEditingController();
  TextEditingController _amountToReceiveController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45.0),
                  child: Text("Crypto - Mobile", style: headerTitle,),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    child: Text("Type de crypto", style: style1,),
                  ),
                  DropdownButtonFormField(
                    key: _key,
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
                    child: Text("Montant en crypto", style: style1,),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _cryptoAmountController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value) => _cryptoAmountController.text,
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Montant à recevoir", style: style1,),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _amountToReceiveController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value)=>_amountToReceiveController,
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Numéro de téléphone", style: style1,),
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value) => _phoneNumberController.text,
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    text: "PROCEDER",
                    onPressed: (){
                      if(!_formKey.currentState!.validate()) return;
                      context.read<CryptoToMobileProvider>().initialState();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Validation1Screen(
                        cryptoAmount: _cryptoAmountController.text.toString(),
                        amountToReceive: _amountToReceiveController.text.toString(),
                        phoneNumber: _phoneNumberController.text.toString(),
                        cryptoType: cryptoType,
                      )));
                      _cryptoAmountController.clear();
                      _amountToReceiveController.clear();
                      _phoneNumberController.clear();
                      _key.currentState!.reset();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
