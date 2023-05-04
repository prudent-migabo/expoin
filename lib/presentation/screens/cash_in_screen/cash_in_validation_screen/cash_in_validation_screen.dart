import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';
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
  final TextEditingController _transactionIDController = TextEditingController();
  String? mobileType;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CashInProvider>().state;
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
                decoration: transactionFieldDecor(hintText: 'Selectionnez'),
                items: ListHelper.mobileMoneyOperators.map(buildMenuItem).toList(),
                onChanged: (value) {
                  setState(() {
                    mobileType = value.toString();
                  });
                },
              ),
              const SizedBox(height: 20,),
              StreamBuilder<MobileMoneyModel>(
                  stream: context.watch<MobileRepository>().getMobileModel(mobileName: mobileType, boutiqueID: MesPiecesBloc.selectedBoutiqueID),
                  builder: (context, snapshot) {
                    MobileMoneyModel? mobileMoneyModel = snapshot.data;
                    if(!snapshot.hasData){
                      return Row(
                        children: [
                          Text("Code d'agent : "),
                          SizedBox(width: 10,),
                          Text('+243 ******', style: textStyleBold,),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Text("Code d'agent : "),
                        SizedBox(width: 10,),
                        SelectableText(
                          mobileMoneyModel!.number! , style: textStyleBold,),
                        GestureDetector(
                            onTap: (){
                              Clipboard.setData(ClipboardData(text: mobileMoneyModel.number),);
                              successToast(message: 'Numéro copié dans clipboard');
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
                decoration: transactionFieldDecor(hintText: 'Collez le message ici'),
                maxLines: 5,
                validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value)=> saveFieldsData(),
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