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

class CashInValidationScreen extends StatefulWidget {
   CashInValidationScreen({Key? key, this.mobileAmount, this.amountToReceive, this.cryptoNumber, this.mobileOperator, this.cryptoType}) : super(key: key);
  static const String routeName = "/Validation1Screen";
  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
        builder: (context)=> CashInValidationScreen());
  }
  String? cryptoType;
  String? mobileOperator;
  String? mobileAmount;
  String? amountToReceive;
  String? cryptoNumber;

  @override
  State<CashInValidationScreen> createState() => _CashInValidationScreenState();
}

class _CashInValidationScreenState extends State<CashInValidationScreen> {
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
  String? mobileType;

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
                            child: Text("Type de mobile money :", style: style1,),
                          ),
                  DropdownButtonFormField(
                    key: _key1,
                    value: mobileType,
                    decoration: textFieldDecoration(),
                    items: ListHelper().listMobileOperator.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        mobileType = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Code d'agent : "),
                      Text('0995006529', style: kTextBold,),
                      Icon(Icons.copy),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Veuillez copier le message de la transaction ici bas et effacer votre solde"),
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
