import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class CashOutValidationScreen extends StatefulWidget {
  const CashOutValidationScreen({Key? key}) : super(key: key);

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
  final TextEditingController _transactionIDController = TextEditingController();
  final TextEditingController _cryptoTypeController = TextEditingController();
  final BoutiqueRepository _repository = BoutiqueRepository();
  String cryptoType = '';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CashOutProvider>().state;
    final cashOutModelState = context.watch<SaveCashOutDetailsController>().cashOutModel;
    String cryptoTypeVal = context.watch<HashNumberProvider>().cashOutCryptoType;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _cryptoTypeController.text = cryptoTypeVal;
    });

    if(state.cashOutStatus == CashOutStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _transactionIDController.clear();
        _cryptoTypeController.clear();
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
                style: GoogleFonts.dmSans(fontSize: 13),
                enabled: false,
                controller: _cryptoTypeController,
                decoration: transactionFieldDecor(hintText: "En attente..."),
              ),
              SizedBox(height: 20,),
              Text("WALLET MES PIECES:", style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              StreamBuilder<CryptoModel>(
                  stream: _repository.getBoutiqueCryptoModel(MesPiecesBloc.selectedBoutiqueID, cryptoTypeVal),
                  builder: (context, snapshot) {
                    CryptoModel? cryptoModel = snapshot.data;
                    if(!snapshot.hasData){
                      return Text('Wallet non disponible');
                    }
                    if (snapshot.hasError){
                      errorDialog(context, content: snapshot.error.toString());
                    }
                    return Row(
                      children: [
                        Expanded(child: SelectableText(cryptoModel!.walletAddress!,)),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: cryptoModel.walletAddress));
                            successToast(message: 'Adresse copiée dans clipboard');
                          },
                          child: Icon(Icons.copy),),
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
                decoration: transactionFieldDecor(hintText: "En attente..."),
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
    context.read<SaveCashOutDetailsController>().saveCashOutDetails(
        CashOutModel(
            cryptoType: '',
            amountToSend: '',
            phoneMobileNumber: '',
            transactionID: _transactionIDController.text)
    );
  }

}
