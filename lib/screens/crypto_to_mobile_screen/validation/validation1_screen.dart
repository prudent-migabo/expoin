import 'package:expoin/models/models.dart';
import 'package:expoin/providers/crypto_to_mobile_provider/crypto_to_mobile_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Validation1Screen extends StatelessWidget {
   Validation1Screen({Key? key, this.cryptoAmount, this.amountToReceive, this.phoneNumber, this.cryptoType}) : super(key: key);
  static const String routeName = "/Validation1Screen";
  static Route route(){
    return MaterialPageRoute(builder: (context)=> Validation1Screen());
  }
   final _formKey = GlobalKey<FormState>();
  String? cryptoAmount;
  String? amountToReceive;
  String? phoneNumber;
  String? cryptoType;
  TextEditingController _transactionIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<CryptoToMobileProvider>().state;
    if(state.cryptoToMobileStatus == CryptoToMobileStatus.isLoaded){
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        print("Success");
         Fluttertoast.showToast(msg: "Message envoyé à l'administration");
       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
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
                  topLeftRadius: 20,
                  topRightRadius: 20,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: padding1,
                      child: Text("Numéro de compte", style: style1,),
                    ),
                    TextFormField(
                      decoration: textFieldDecoration(hintText: "0123456789"),
                      //onChanged: (value){},
                    ),
                    Padding(
                      padding: padding1,
                      child: Text("ID de la transaction", style: style1,),
                    ),
                    TextFormField(
                      controller: _transactionIDController,
                      decoration: textFieldDecoration(hintText: ""),
                      validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
                      onChanged: (value) => _transactionIDController.text,
                    ),
                    SizedBox(height: 35,),
                    CustomButton(
                      text: state.cryptoToMobileStatus == CryptoToMobileStatus.isLoading? "PATIENTEZ..." : "EFFECTUER",
                      onPressed: state.cryptoToMobileStatus == CryptoToMobileStatus.isLoading? (){}:() async{
                        if(!_formKey.currentState!.validate()) return;
                        try{
                          await context.read<CryptoToMobileProvider>().addCryptoToMobile(
                            transactionID: _transactionIDController.text,
                            phone: phoneNumber,
                            amountToReceive: amountToReceive,
                            cryptoAmount: cryptoAmount,
                            cryptoType: cryptoType,
                          );
                          _transactionIDController.clear();
                        } on CustomError catch(e){
                          return errorDialog(context, e);
                        }
                      },
                    )
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
