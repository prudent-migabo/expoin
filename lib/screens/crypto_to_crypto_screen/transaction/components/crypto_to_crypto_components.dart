import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CryptoToCryptoComponents extends StatefulWidget {
   CryptoToCryptoComponents({Key? key}) : super(key: key);

  @override
  State<CryptoToCryptoComponents> createState() => _CryptoToCryptoComponentsState();
}

class _CryptoToCryptoComponentsState extends State<CryptoToCryptoComponents> {

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }
  final _formKey = GlobalKey<FormState>();
  String? cryptoType1;
  String? cryptoType2;
  TextEditingController _cryptoAmountController = TextEditingController();
  TextEditingController _amountToReceiveController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 45.0),
                    child: Text("Crypto - Crypto", style: headerTitle),
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
                topLeftRadius: 20,
                topRightRadius: 20,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: padding1,
                    child: Text("Type de crypto 1", style: style1,),
                  ),
                  DropdownButtonFormField(
                    value: cryptoType1,
                    decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
                    items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        cryptoType1 = value.toString();
                      });
                    },
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Montant en crypto", style: style1,),
                  ),
                  TextFormField(
                    controller: _cryptoAmountController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value)=> _cryptoAmountController.text,
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Type de crypto 2", style: style1,),
                  ),
                  DropdownButtonFormField(
                    value: cryptoType2,
                    decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
                    items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        cryptoType2 = value.toString();
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
                    validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value)=>_amountToReceiveController.text,
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    text: "PROCEDER",
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Validation3Screen(
                        cryptoType1: cryptoType1,
                        cryptoType2: cryptoType2,
                        cryptoAmount: _cryptoAmountController.text.toString(),
                        amountToReceive: _amountToReceiveController.text.toString(),
                      )));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
