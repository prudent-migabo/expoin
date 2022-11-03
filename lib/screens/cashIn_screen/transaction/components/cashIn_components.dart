import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashIn_screen/transaction/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CashInComponents extends StatefulWidget {
  const CashInComponents({Key? key}) : super(key: key);

  @override
  State<CashInComponents> createState() => _CashInComponentsState();
}

class _CashInComponentsState extends State<CashInComponents> {

  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var state = context.watch<CashInProvider>().state;
    var cashInModelState = context.watch<SaveCashInDetailsController>().cashInModel;
    var userName = context.watch<UserModel>().firstName;

    if(state.cashInStatus == CashInStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Fluttertoast.showToast(msg: "Votre requete est soumise a l'administration avec succes, vous recevrez la suite dans une heure");
        context.read<CashInProvider>().initialState();
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
                          onPressed: state.cashInStatus == CashInStatus.isLoading? (){} : () async{
                            if(!_formKey.currentState!.validate()) return;
                            try{
                             await context.read<CashInProvider>().addCashIn(
                                  CashInModel(
                                      cryptoType: cashInModelState.cryptoType,
                                      amountToSend: cashInModelState.amountToSend,
                                      amountToReceive: context.read<CashInCalculationProvider>().result.toString(),
                                      hashNumber: cashInModelState.hashNumber,
                                      mobileType: cashInModelState.mobileType,
                                      transactionID: cashInModelState.transactionID,
                                    userName: userName,
                                    isPending: true,
                                  ));
                            } on CustomError catch(e){
                              errorDialog(context, e);
                            }
                          },
                          child:  Text(state.cashInStatus == CashInStatus.isLoading?'PATIENTEZ...':'CONFIRMER'),
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
                    CashInTransactionForm(),
                  ],
                ),
                  isActive: currentStep>=0
                ),
                Step(title: Text("Confirmez la transaction :", style: kTextBold,), content: Column(
                  children: [
                    CashInValidationScreen(),
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
