import 'package:expoin/providers/mobile_to_crypto_provider/mobile_to_crypto_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashIn_screen/transaction/components/components.dart';
import 'package:expoin/screens/cashOut_screen/transaction/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashOutComponents extends StatefulWidget {
  const CashOutComponents({Key? key}) : super(key: key);

  @override
  State<CashOutComponents> createState() => _CashOutComponentsState();
}

class _CashOutComponentsState extends State<CashOutComponents> {

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<MobileToCryptoProvider>().state;
    return  Column(
      children: [
        Expanded(
          child: Stepper(
            currentStep: currentStep,
            onStepTapped: (step) => tapped(step),
            controlsBuilder: (context, _){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  currentStep == 0 ?
                  ElevatedButton(
                    onPressed: (){
                      continued();
                    },
                    child: const Text('PROCEDER'),
                  ) :  Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          continued();
                        },
                        child: const Text('CONFIRMER'),
                      ),
                      SizedBox(width: 40,),
                      ElevatedButton(
                        onPressed: (){
                          cancel();
                        },
                        child: const Text('ANNULER'),
                      ),
                    ],
                  )


                ],
              );
            },
            steps: [
              Step(
                  title: Text("Demarrez la transaction en toute securité :", style: kTextBold,),
                  content: Column(
                    children: [
                      CashOutTransactionForm(),
                    ],
                  ),
                  isActive: currentStep>=0
              ),
              Step(title: Text("Confirmez la transaction :", style: kTextBold,), content: Column(
                children: [
                  CashOutValidationScreen(),
                ],
              ),
                  isActive: currentStep>=1
              ),
            ],),

        ),

      ],
    );

  }
  tapped(int step){
    setState(() => currentStep = step);
  }

  continued(){
    currentStep < 1 ?
    setState(() => currentStep += 1): null;
  }

  cancel(){
    currentStep > 0 ?
    setState(() => currentStep -= 1) : null;
  }

  Future logout() async{
    await context.read<AuthRepository>().signOutUSer();
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
}

// Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//               height: double.infinity,
//               // height: 540,
//               width: width,
//               color: Color(0xfff7f7f7),
//
//               child: ListView(
//                 children: [
//                   Stepper(
//                     currentStep: currentStep,
//                     steps: [
//                     Step(title: Text("Premiere"), content: Column(
//                       children: [
//                         Padding(
//                           padding: padding1,
//                           child: Text("Type de crypto", style: style1,),
//                         ),
//                         DropdownButtonFormField(
//                           key: _key1,
//                           value: cryptoType,
//                           decoration: textFieldDecoration(hintText: ListHelper().listCryptoCategory[0]),
//                           items: ListHelper().listCryptoCategory.map(buildMenuItem).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               cryptoType = value.toString();
//                             });
//                           },
//                         ),
//
//                         Padding(
//                           padding: padding1,
//                           child: Text("\$ à envoyer", style: style1,),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextFormField(
//                               keyboardType: TextInputType.number,
//                               controller: _cryptoTypeController,
//                               decoration: textFieldDecoration(hintText: ""),
//                               validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
//                               onChanged: (value) => _amountToSendController.text,
//                             ),
//                             Column(
//                               children: [
//                                 Text('A recevoir'),
//                                 SizedBox(height: 10,),
//                                 Text("00003"),
//                               ],
//                             )
//                           ],
//                         ),
//
//                         Padding(
//                           padding: padding1,
//                           child: Text("Numéro Hash", style: style1,),
//                         ),
//
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           controller: _hashNumberController,
//                           decoration: textFieldDecoration(hintText: ""),
//                           validator: (value) => value!.isEmpty? "Ce champ ne peut être vide": null,
//                           onChanged: (value) => _hashNumberController.text,
//                         ),
//                         SizedBox(height: 30,),
//                         CustomButton(
//                           text: "PROCEDER",
//                           onPressed: (){
//                             if(!_formKey.currentState!.validate()) return;
//                             context.read<MobileToCryptoProvider>().initialState();
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=> CashInValidationScreen(
//                               cryptoType: cryptoType,
//                               mobileOperator: mobileOperator,
//                               mobileAmount: _cryptoTypeController.text.toString(),
//                               amountToReceive: _amountToSendController.text.toString(),
//                               cryptoNumber: _hashNumberController.text.toString(),
//                             )));
//                           },
//                         ),
//                       ],
//                     )),
//                       Step(title: Text('Deuxieme'), content: CashInValidationScreen()),
//                   ],),
//
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );