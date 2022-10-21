import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
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
   void initState() {
     super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       context.read<CashInCalculationProvider>().initializer();
     });
   }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var rate1 = context.watch<CashInRateModel>().rate1;
    var rate2 = context.watch<CashInRateModel>().rate2;
    var rate3 = context.watch<CashInRateModel>().rate3;
    var rate4 = context.watch<CashInRateModel>().rate4;


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
                  controller: _mobileAmountController,
                  decoration: textFieldDecoration(hintText: ""),
                  onChanged: (value) async{
                    if(value.isNotEmpty){
                      await context.read<CashInCalculationProvider>().cashInCalculation(
                          context : context,
                          value: _mobileAmountController.text,
                        rate1: rate1,
                        rate2: rate2,
                        rate3: rate3,
                        rate4: rate4,
                      );
                    } else{
                      context.read<CashInCalculationProvider>().initializer();
                    }
                },
                ),
                ContainerForCalculator(
                  content: "${context.watch<CashInCalculationProvider>().result.toString()}\$",
                  title: "Montant à recevoir en",),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
