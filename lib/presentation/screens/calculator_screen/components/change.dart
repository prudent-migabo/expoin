import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ChangeCalculationProvider>().initializer();
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var rate1 = context.watch<ChangeRateModel>().rate1;
    var rate2 = context.watch<ChangeRateModel>().rate2;
    var rate3 = context.watch<ChangeRateModel>().rate3;
    var rate4 = context.watch<ChangeRateModel>().rate4;

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
                  decoration: transactionFieldDecor(hintText: ListHelper.cryptosCategories[0]),
                  items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
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
                  controller: _cryptoAmountController,
                  decoration: transactionFieldDecor(hintText: ""),
                  onChanged: (value) {
                    if(value.isNotEmpty){
                      context.read<ChangeCalculationProvider>().changeCalculation(
                        context: context,
                        value: _cryptoAmountController.text,
                        rate1: rate1,
                        rate2: rate2,
                        rate3: rate3,
                        rate4: rate4,
                      );
                    } else{
                     context.read<ChangeCalculationProvider>().initializer();
                    }
                  },
                ),
                Padding(
                  padding: padding1,
                  child: Text("Type de crypto de conversion", style: style1,),
                ),
                DropdownButtonFormField(
                  value: cryptoType2,
                  decoration: transactionFieldDecor(hintText: ListHelper.cryptosCategories[0]),
                  items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      cryptoType2 = value.toString();
                    });
                  },
                ),
                ContainerForCalculator(content : "${context.watch<ChangeCalculationProvider>().result.toString()}\$",
                  title: "Montant à recevoir en crypto",),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
