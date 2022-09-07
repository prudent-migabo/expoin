import 'package:expoin/models/models.dart';
import 'package:expoin/providers/cashOut_provider/cashOut_state.dart';
import 'package:expoin/providers/cashOut_provider/retreive_cashout_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashOut extends StatefulWidget {
  const CashOut({Key? key}) : super(key: key);

  @override
  State<CashOut> createState() => _CashOutState();
}

class _CashOutState extends State<CashOut> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  String? cryptoType;
  String? mobileType;
  double displayResult = 0.0;
  double? resultRate;
  final GlobalKey<FormFieldState> _key1 = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _key2 = GlobalKey<FormFieldState>();
  TextEditingController _cryptoAmountController = TextEditingController();

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var rate = context.watch<RateModel>().rate;

    Future<double> calculation() async{
      if(_cryptoAmountController.text != ''){
        double result =  double.parse(_cryptoAmountController.text) * double.parse(rate!);
        setState(() {
          displayResult = result;
        });
        print("ooooooooooooooooooooooooooooooooooooooooooooooo ${result}");
        print("lllllllllllllllllllllllllllllllllllllllllllllllll ${displayResult}");
        return result;
      } else{
        return 0.0;
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
             // height: 600,
              width: width,
              color: Color(0xfff7f7f7),
              child: ListView(
                children: [
                  Padding(
                    padding: padding1,
                    child: Text("Type de crypto", style: style1,),
                  ),
                  DropdownButtonFormField(
                    key: _key1,
                    value: cryptoType,
                    decoration: textFieldDecoration(),
                    items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        cryptoType = value.toString();
                      });
                    },
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Type de Mobile", style: style1,),
                  ),
                  DropdownButtonFormField(
                    key: _key2,
                    value: mobileType,
                    decoration: textFieldDecoration(),
                    items: ListHelper().listMobileOperator.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        mobileType = value.toString();
                      });
                    },
                  ),
                  Padding(
                    padding: padding1,
                    child: Text("Montant en crypto", style: style1,),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _cryptoAmountController,
                    decoration: textFieldDecoration(),
                    validator: (value) => value!.isEmpty? "Rien à calculer": null,
                    onChanged: (value) {
                      if(value.isEmpty){
                        setState(() {
                          displayResult = 0.0;
                        });
                      }
                      calculation();
                    },
                  ),
                    ContainerForCalculator(
                        content: displayResult.toString(),
                        title: "Montant à recevoir en \$",),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
