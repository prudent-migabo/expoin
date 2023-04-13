import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';

class ChangeValidationScreen extends StatefulWidget {
  const ChangeValidationScreen({Key? key}) : super(key: key);

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

  final _formKey = GlobalKey<FormState>();
  TextEditingController _transactionIDController = TextEditingController();
  TextEditingController _cryptoTypeController = TextEditingController();
  final BoutiqueRepository _repository = BoutiqueRepository();
  String? cryptoType;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangeProvider>().state;
    String cryptoTypeVal = context.watch<HashNumberProvider>().changeCryptoType;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cryptoTypeController.text = cryptoTypeVal;
    });

    if(state.changeStatus == ChangeStatus.isLoaded){
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
                        print('errorrrrrr ${snapshot.error.toString()}');
                      }
                      return Row(
                        children: [
                          SelectableText(cryptoModel!.walletAddress!,),
                          SizedBox(width: 5,),
                          GestureDetector(
                              onTap: (){
                                Clipboard.setData(ClipboardData(text: cryptoModel.walletAddress));
                                successToast(message: 'Code copié dans clipboard');
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
                  decoration: transactionFieldDecor(hintText: "Saisissez ici"),
                  maxLines: 5,
                  validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                  onChanged: (value)=> saveFieldsData(),
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
