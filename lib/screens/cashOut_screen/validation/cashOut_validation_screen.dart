import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _transactionIDController = TextEditingController();
  TextEditingController _cryptoTypeController = TextEditingController();
  String? cryptoType;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashOutProvider>().state;
    final cashOutModelState = context.watch<SaveCashOutDetailsController>().cashOutModel;
    String cryptoTypeVal = context.watch<HashNumberProvider>().cashOutCryptoType;

    _cryptoTypeController.text = cashOutModelState.cryptoType;

    if(state.cashOutStatus == CashOutStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _transactionIDController.clear();
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
                TextFormField(
                  enabled: false,
                  controller: _cryptoTypeController,
                  decoration: textFieldDecoration(hintText: "En attente..."),
                ),
                SizedBox(height: 20,),
                Text("WALLET MES PIECES:", style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                StreamBuilder<HashNumberModel>(
                  stream: context.watch<HashNumberProvider>().getHash(context, cryptoTypeVal),
                  builder: (context, snapshot) {
                    HashNumberModel? hashNumberModel = snapshot.data;
                    if(!snapshot.hasData){
                      return Text('Wallet non disponible');
                    }
                    return Row(
                      children: [
                        Expanded(child: SelectableText(hashNumberModel!.hashNumber, style: kTextBold,)),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: hashNumberModel.hashNumber));
                            Fluttertoast.showToast(msg: 'Code copié dans clipboard');
                          },
                            child: Icon(Icons.copy)),
                      ],
                    );
                  }
                ),
                SizedBox(height: 20,),
                Text("Veuillez copier le message de confirmation ici dessous"),
                SizedBox(height: 20,),
                Padding(
                  padding: padding1.copyWith(top: 0, bottom: 10),
                  child: Text("HASH :", style: style1,),
                ),
                TextFormField(
                  controller: _transactionIDController,
                  decoration: textFieldDecoration(hintText: "Saisissez ici"),
                  maxLines: 5,
                  validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                  onChanged: (value) => saveFieldsData(),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void saveFieldsData(){
    context.read<SaveCashOutDetailsController>().saveCashOutDetails(
        CashOutModel(
            cryptoType: '',
            amountToSend: '',
            phoneMobileNumber: '',
            transactionID: _transactionIDController.text)
    );
  }

}
