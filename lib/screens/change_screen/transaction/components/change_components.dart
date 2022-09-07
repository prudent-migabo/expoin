import 'package:expoin/providers/crypto_to_crypto_provider/crypto_to_crypto_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangeComponents extends StatefulWidget {
   ChangeComponents({Key? key}) : super(key: key);

  @override
  State<ChangeComponents> createState() => _ChangeComponentsState();
}

class _ChangeComponentsState extends State<ChangeComponents> {

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
  final GlobalKey<FormFieldState> _key2 = GlobalKey<FormFieldState>();
  String? cryptoType1;
  String? cryptoType2;
  TextEditingController _cryptoAmountController = TextEditingController();
  TextEditingController _amountToReceiveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<CryptoToCryptoProvider>().state;
    if(state.cryptoToCryptoStatus == CryptoToCryptoStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _key1.currentState!.reset();
        _key2.currentState!.reset();
        _cryptoAmountController.clear();
        _amountToReceiveController.clear();
      });
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Container(
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 45.0),
          //         child: Text("Crypto - Crypto", style: headerTitle),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 540,
              width: width,
              color: Color(0xfff7f7f7),
              // decoration: containerBodyDecoration(
              //   color: Color(0xfff7f7f7),
              //   topLeftRadius: 20,
              //   topRightRadius: 20,
              // ),
              child: ListView(
                children: [
                  Padding(
                    padding: padding1,
                    child: Text("Type de crypto 1", style: style1,),
                  ),
                  DropdownButtonFormField(
                    key: _key1,
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
                    keyboardType: TextInputType.number,
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
                    key: _key2,
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
                    keyboardType: TextInputType.number,
                    controller: _amountToReceiveController,
                    decoration: textFieldDecoration(hintText: ""),
                    validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                    onChanged: (value)=>_amountToReceiveController.text,
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    text: "PROCEDER",
                    onPressed: (){
                      if(!_formKey.currentState!.validate()) return;
                      context.read<CryptoToCryptoProvider>().initialState();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeValidationScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
