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

  final GlobalKey<FormFieldState> _key1 = GlobalKey<FormFieldState>();
  TextEditingController _transactionIDController = TextEditingController();
  String? mobileType;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<CashInProvider>().state;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context.read<SaveCashInDetailsController>().saveFormState(formKey);
    // });

    if(state.cashInStatus == CashInStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _transactionIDController.clear();
      });
    }
    return  Column(
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
                decoration: textFieldDecoration(
                  hintText: ListHelper().listMobileOperator[0],
                ),
                items: ListHelper().listMobileOperator.map(buildMenuItem).toList(),
                onChanged: (value) {
                  setState(() {
                    mobileType = value.toString();
                  });
                  saveFieldsData();
                },
              ),
              SizedBox(height: 20,),
              StreamBuilder<PhoneNumbersModel>(
                stream: context.watch<PhoneNumbersRepository>().getNumbers(),
                builder: (context, snapshot) {
                  PhoneNumbersModel? phoneNumberModel = snapshot.data;
                  if(!snapshot.hasData){
                    return Text("Code d'agent non disponible");
                  }
                  return Row(
                    children: [
                      Text("Code d'agent : "),
                      SizedBox(width: 10,),
                      SelectableText(
                        mobileType == 'Airtel money' ? phoneNumberModel!.airtel :
                        mobileType == 'Orange money'? phoneNumberModel!.orange :
                        mobileType== 'M-Pesa'? phoneNumberModel!.mpesa :
                        mobileType == 'Western'? '0129837409847' :
                        '099*******', style: kTextBold,),
                      GestureDetector(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text:
                          mobileType == 'Airtel money' ? phoneNumberModel!.airtel :
                          mobileType == 'Orange money'? phoneNumberModel!.orange :
                          mobileType== 'M-Pesa'? phoneNumberModel!.mpesa :
                          mobileType == 'Western'? '0129837409847' :
                          '099*******',));
                          Fluttertoast.showToast(msg: 'Numero copié dans clipboard');
                        },
                          child: Icon(Icons.copy)),
                    ],
                  );
                }
              ),
              SizedBox(height: 20,),
              Text("Veuillez copier le message de la transaction ici bas et effacer votre solde"),
              SizedBox(height: 20,),
              Padding(
                padding: padding1.copyWith(top: 0, bottom: 10),
                child: Text("ID de la transaction :", style: style1,),
              ),
              TextFormField(
                controller: _transactionIDController,
                decoration: textFieldDecoration(hintText: "Collez le message ici"),
                maxLines: 5,
                validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value){
                  saveFieldsData();
                },
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ],
    );
  }

  void saveFieldsData(){
    context.read<SaveCashInDetailsController>().saveCashInDetails(
        CashInModel(
            cryptoType: '',
            amountToSend: '',
            hashNumber: '',
            mobileType: mobileType!,
            transactionID: _transactionIDController.text));
  }
}
