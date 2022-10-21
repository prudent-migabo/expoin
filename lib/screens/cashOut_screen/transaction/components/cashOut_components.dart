import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashIn_screen/transaction/components/components.dart';
import 'package:expoin/screens/cashOut_screen/transaction/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CashOutComponents extends StatefulWidget {
  const CashOutComponents({Key? key}) : super(key: key);

  @override
  State<CashOutComponents> createState() => _CashOutComponentsState();
}

class _CashOutComponentsState extends State<CashOutComponents> {

  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<CashOutProvider>().state;
    final cashOutModelState = context.watch<SaveCashOutDetailsController>().cashOutModel;
    var userName = context.watch<UserModel>().firstName;

    if(state.cashOutStatus == CashOutStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Fluttertoast.showToast(msg: "Vos données ont été envoyées à l'administration avec succes");
        context.read<CashOutProvider>().initialState();
      });
    }

    return  Form(
      key: _formKey,
      child: Column(
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
                          onPressed: state.cashOutStatus == CashOutStatus.isLoading? (){} : () async{
                            if(!_formKey.currentState!.validate()) return;
                            try{
                              await context.read<CashOutProvider>().addCashOut(
                                CashOutModel(
                                    cryptoType: cashOutModelState.cryptoType,
                                    amountToSend: cashOutModelState.amountToSend,
                                    phoneMobileNumber: cashOutModelState.phoneMobileNumber,
                                    transactionID: cashOutModelState.transactionID,
                                  userName: userName,
                                  isPending: true,
                                ),
                              );
                            }on CustomError catch(e){
                              errorDialog(context, e);
                            }
                          },
                          child: Text(state.cashOutStatus == CashOutStatus.isLoading?'PATIENTEZ...':'CONFIRMER'),
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
      ),
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
