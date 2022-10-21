import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ChangeValidationScreen extends StatefulWidget {
  ChangeValidationScreen({Key? key}) : super(key: key);
  static const String routeName = "/Validation1Screen";
  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> ChangeValidationScreen());
  }

  @override
  State<ChangeValidationScreen> createState() => _ChangeValidationScreenState();
}

class _ChangeValidationScreenState extends State<ChangeValidationScreen> {
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }

  TextEditingController _transactionIDController = TextEditingController();
  TextEditingController _cryptoTypeController = TextEditingController();
  String? cryptoType;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangeProvider>().state;
    final changeModelState = context.watch<SaveChangeDetailsController>().changeModel;
    _cryptoTypeController.text = changeModelState.cryptoTypeToSend;

    if(state.changeStatus == ChangeStatus.isLoaded){
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
                child: Text("Type de crypto :", style: style1,),
              ),
              TextFormField(
                enabled: false,
                controller: _cryptoTypeController,
                decoration: textFieldDecoration(hintText: "BTC"),
                validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                onChanged: (value) {
                  saveFieldsData();
                },
              ),
              SizedBox(height: 20,),
              Text("HASH MES PIECES"),
              SizedBox(height: 15,),
              StreamBuilder<HashNumberModel>(
                  stream: context.watch<HashNumberRepository>().getHashNumber(),
                  builder: (context, snapshot) {
                    HashNumberModel? hashNumberModel = snapshot.data;
                    if(!snapshot.hasData){
                      return Text('Code non disponible');
                    }
                    return Row(
                      children: [
                        SelectableText(hashNumberModel!.hashNumber, style: kTextBold,),
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
                child: Text("Message de la transaction :", style: style1,),
              ),
              TextFormField(
                controller: _transactionIDController,
                decoration: textFieldDecoration(hintText: "Saisissez ici"),
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
    context.read<SaveChangeDetailsController>().saveChangeDetails(
        ChangeModel(
            cryptoTypeToSend: '',
            cryptoTypeToReceive: '',
            cryptoAmountToSend: '',
            hashNumber: '',
            transactionMessage: _transactionIDController.text)
    );
  }

}
