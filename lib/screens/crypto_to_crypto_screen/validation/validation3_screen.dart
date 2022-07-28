import 'package:expoin/models/models.dart';
import 'package:expoin/providers/crypto_to_crypto_provider/crypto_to_crypto_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Validation3Screen extends StatefulWidget {
  Validation3Screen({Key? key, this.cryptoType1, this.cryptoType2, this.cryptoAmount, this.amountToReceive}) : super(key: key);
  static const String routeName = "/Validation1Screen";
  static Route route(){
    return MaterialPageRoute(builder: (context)=> Validation3Screen());
  }
  String? cryptoType1;
  String? cryptoType2;
  String? cryptoAmount;
  String? amountToReceive;

  @override
  State<Validation3Screen> createState() => _Validation3ScreenState();
}

class _Validation3ScreenState extends State<Validation3Screen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _cryptoNumberController = TextEditingController();
  TextEditingController _transactionIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<CryptoToCryptoProvider>().state;
    if(state.cryptoToCryptoStatus == CryptoToCryptoStatus.isLoaded){
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        print("Success");
        Fluttertoast.showToast(msg: "Message envoyé à l'administration");
      //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
      });
    }
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_rounded, color: Colors.white,)),
                        Text("Validation", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                        IconButton(onPressed: (){
                          Navigator.pushNamed(context, BottomNavigationScreen.routeName);
                        }, icon: Icon(Icons.home, color: Colors.white,)),
                      ],
                    ),
                  ),
                  // SizedBox(height: 40,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 650,
                width: width,
                decoration: containerBodyDecoration(
                  color: Color(0xfff7f7f7),
                  topLeftRadius: 25,
                  topRightRadius: 25,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: padding1,
                      child: Text("Numéro de compte", style: style1,),
                    ),
                    TextFormField(
                      controller: _cryptoNumberController,
                      decoration: textFieldDecoration(hintText: ""),
                      validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                      onChanged: (value)=> _cryptoNumberController.text,
                    ),
                    Padding(
                      padding: padding1,
                      child: Text("ID de la transaction", style: style1,),
                    ),
                    TextFormField(
                      controller: _transactionIDController,
                      decoration: textFieldDecoration(hintText: ""),
                      validator: (value)=> value!.isEmpty? "Ce champ ne peut être vide": null,
                      onChanged: (value) => _transactionIDController.text,
                    ),
                    SizedBox(height: 30,),
                    CustomButton(
                      text: state.cryptoToCryptoStatus == CryptoToCryptoStatus.isLoading?"PATIENTEZ...":"EFFECTUER",
                      onPressed: state.cryptoToCryptoStatus == CryptoToCryptoStatus.isLoading?(){}:() async{
                        if(!_formKey.currentState!.validate()) return;
                        try{
                          await context.read<CryptoToCryptoProvider>().addCryptoToCrypto(
                            cryptoNumber: _cryptoNumberController.text,
                            transactionID: _transactionIDController.text,
                            amountToReceive: widget.amountToReceive,
                            cryptoAmount: widget.cryptoAmount,
                            cryptoType1: widget.cryptoType1,
                            cryptoType2: widget.cryptoType2,
                          );
                          _cryptoNumberController.clear();
                          _transactionIDController.clear();
                        }
                        on CustomError catch(e){
                          return errorDialog(context, e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
