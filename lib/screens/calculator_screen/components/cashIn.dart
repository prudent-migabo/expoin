import 'package:expoin/models/models.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashIn extends StatefulWidget {
   CashIn({Key? key}) : super(key: key);

  @override
  State<CashIn> createState() => _CashInState();
}

class _CashInState extends State<CashIn> {
   String? cryptoType;
   double displayResult = 0.0;
   TextEditingController _mobileAmountController = TextEditingController();

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
      if(_mobileAmountController.text != ''){
        double result =  double.parse(_mobileAmountController.text) * double.parse(rate!);
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
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 540,
            width: width,
            color: Color(0xfff7f7f7),
            child: ListView(
              children: [
                Padding(
                  padding: padding1,
                  child: Text("Type de crypto", style: style1,),
                ),
                DropdownButtonFormField(
                  value: cryptoType,
                  decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
                  items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      cryptoType = value.toString();
                    });
                  },
                ),
                Padding(
                  padding: padding1,
                  child: Text("Montant en cash", style: style1,),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileAmountController,
                  decoration: textFieldDecoration(hintText: ""),
                  onChanged: (value){
                    if(value.isEmpty){
                      setState(() {
                        displayResult = 0.0;
                      });
                    }
                    calculation();
                },
                ),
                ContainerForCalculator(content: displayResult.toString(), title: "Montant à recevoir en crypto",),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
