import 'package:expoin/models/models.dart';
import 'package:expoin/providers/mobile_to_crypto_provider/mobile_to_crypto_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Validation2Screen extends StatelessWidget {
   Validation2Screen({Key? key, this.mobileAmount, this.amountToReceive, this.cryptoNumber, this.mobileOperator, this.cryptoType}) : super(key: key);
  static const String routeName = "/Validation1Screen";
  static Route route(){
    return MaterialPageRoute(builder: (context)=> Validation2Screen());
  }
  final _formKey = GlobalKey<FormState>();
  String? cryptoType;
  String? mobileOperator;
  String? mobileAmount;
  String? amountToReceive;
  String? cryptoNumber;
  TextEditingController _agentNumberController = TextEditingController();
  TextEditingController _transactionIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<MobileToCryptoProvider>().state;
    if(state.mobileToCryptoStatus == MobileToCryptoStatus.isLoaded){
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
      });
    }
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Text("Validation", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 650,
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
                      child: Text("Numéro d'agent", style: style1,),
                    ),
                    TextFormField(
                      controller: _agentNumberController,
                      decoration: textFieldDecoration(hintText: ""),
                      validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                      onChanged: (value)=> _agentNumberController.text,
                    ),
                    Padding(
                      padding: padding1,
                      child: Text("ID de la transaction", style: style1,),
                    ),
                    TextFormField(
                      controller: _transactionIDController,
                      decoration: textFieldDecoration(hintText: ""),
                      validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                      onChanged: (value)=> _transactionIDController.text,
                    ),
                    SizedBox(height: 30,),
                    CustomButton(
                      text: state.mobileToCryptoStatus == MobileToCryptoStatus.isLoading?"PATIENTEZ...":"EFFECTUER",
                      onPressed: state.mobileToCryptoStatus == MobileToCryptoStatus.isLoading?(){}:() async{
                        if(!_formKey.currentState!.validate()) return;
                        try{
                          await context.read<MobileToCryptoProvider>().addMobileToCrypto(
                            cryptoType: cryptoType,
                            amountToReceive: amountToReceive,
                            transactionID: _transactionIDController.text,
                            agentNumber: _agentNumberController.text,
                            cryptoNumber: cryptoNumber,
                            mobileAmount: mobileAmount,
                            mobileOperator: mobileOperator,
                          );
                        }on CustomError catch(e){
                          return errorDialog(context, e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
