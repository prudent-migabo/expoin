import 'package:expoin/models/models.dart';
import 'package:expoin/providers/mobile_to_crypto_provider/mobile_to_crypto_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CashOutValidationScreen extends StatefulWidget {
  CashOutValidationScreen({Key? key}) : super(key: key);
  static const String routeName = "/Validation1Screen";
  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> CashOutValidationScreen());
  }

  @override
  State<CashOutValidationScreen> createState() => _CashOutValidationScreenState();
}

class _CashOutValidationScreenState extends State<CashOutValidationScreen> {
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
  TextEditingController _transactionIDController = TextEditingController();
  String? cryptoType;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<MobileToCryptoProvider>().state;
    if(state.mobileToCryptoStatus == MobileToCryptoStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        print("Success");
        Fluttertoast.showToast(msg: "Message envoyé à l'administration");
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
      });
    }
    return  Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
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
                  decoration: textFieldDecoration(),
                  items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      cryptoType = value.toString();
                    });
                  },
                ),
                SizedBox(height: 20,),
                Text("Hash Number MES PIECES"),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text('wpefc2230@er!jen#lp0+poe', style: kTextBold,),
                    SizedBox(width: 20,),
                    Icon(Icons.copy),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Veuillez copier le message de confirmation ici dessous"),
                SizedBox(height: 20,),
                Padding(
                  padding: padding1.copyWith(top: 0, bottom: 10),
                  child: Text("Message de la transaction :", style: style1,),
                ),
                TextFormField(
                  controller: _transactionIDController,
                  decoration: textFieldDecoration(hintText: ""),
                  maxLines: 5,
                  validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                  onChanged: (value)=> _transactionIDController.text,
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
