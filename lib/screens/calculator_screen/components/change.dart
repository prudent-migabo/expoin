import 'package:expoin/models/models.dart';
import 'package:expoin/utils/constant.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Change extends StatefulWidget {
  const Change({Key? key}) : super(key: key);

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  String? cryptoType1;
  String? cryptoType2;
  double displayResult = 0.0;
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
                  child: Text("Type de crypto à convertir", style: style1,),
                ),
                DropdownButtonFormField(
                  value: cryptoType1,
                  decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
                  items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      cryptoType1 = value.toString();
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
                  decoration: textFieldDecoration(hintText: ""),
                  onChanged: (value) {
                    if(value.isEmpty){
                      setState(() {
                        displayResult = 0.0;
                      });
                    }
                    calculation();
                  },
                ),
                Padding(
                  padding: padding1,
                  child: Text("Type de crypto de conversion", style: style1,),
                ),
                DropdownButtonFormField(
                  value: cryptoType2,
                  decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
                  items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      cryptoType2 = value.toString();
                    });
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
