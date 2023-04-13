import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class CashOut extends StatefulWidget {
  const CashOut({Key? key}) : super(key: key);

  @override
  State<CashOut> createState() => _CashOutState();
}

class _CashOutState extends State<CashOut> {


  String? cryptoType;
  String? mobileType;
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CashOutCalculationProvider>().initializer();
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var rate1 = context.watch<CashOutRateModel>().rate1;
    var rate2 = context.watch<CashOutRateModel>().rate2;
    var rate3 = context.watch<CashOutRateModel>().rate3;
    var rate4 = context.watch<CashOutRateModel>().rate4;


    return Column(
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
                  decoration: transactionFieldDecor(),
                  items: ListHelper.cryptosCategories.map(buildMenuItem).toList(),
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
                  decoration: transactionFieldDecor(),
                  items: ListHelper.mobileMoneyOperators.map(buildMenuItem).toList(),
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
                  controller: _cryptoAmountController,
                  decoration: transactionFieldDecor(),
                  onChanged: (value) {
                    if(value.isNotEmpty){
                      context.read<CashOutCalculationProvider>().cashOutCalculation(
                        context: context,
                        value: _cryptoAmountController.text,
                        rate1: rate1,
                        rate2: rate2,
                        rate3: rate3,
                        rate4: rate4,
                      );
                    } else{
                      context.read<CashOutCalculationProvider>().initializer();
                    }
                  },
                ),
                  ContainerForCalculator(
                      content: "${context.watch<CashOutCalculationProvider>().result.toString()}\$",
                      title: "Montant à recevoir en \$",),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
