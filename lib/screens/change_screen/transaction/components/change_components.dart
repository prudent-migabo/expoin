import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashIn_screen/transaction/components/components.dart';
import 'package:expoin/screens/cashOut_screen/transaction/components/components.dart';
import 'package:expoin/screens/change_screen/transaction/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangeComponents extends StatefulWidget {
  const ChangeComponents({Key? key}) : super(key: key);

  @override
  State<ChangeComponents> createState() => _ChangeComponentsState();
}

class _ChangeComponentsState extends State<ChangeComponents> {

  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangeProvider>().state;
    final changeModelState = context.watch<SaveChangeDetailsController>().changeModel;
    var userName = context.watch<UserModel>().firstName;

    if(state.changeStatus == ChangeStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Fluttertoast.showToast(msg: "Votre requete est soumise a l'administration avec succes, vous recevrez la suite dans une heure");
        context.read<ChangeProvider>().initialState();
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
                          onPressed: state.changeStatus == ChangeStatus.isLoading? (){} : () async{
                            if(!_formKey.currentState!.validate()) return;
                            try{
                              await context.read<ChangeProvider>().addChange(
                                  ChangeModel(
                                    cryptoTypeToSend: changeModelState.cryptoTypeToSend,
                                    cryptoTypeToReceive: changeModelState.cryptoTypeToReceive,
                                    cryptoAmountToSend: changeModelState.cryptoAmountToSend,
                                    amountToReceive: context.read<ChangeCalculationProvider>().result.toString(),
                                    hashNumber: changeModelState.hashNumber,
                                    transactionMessage: changeModelState.transactionMessage,
                                    userName: userName,
                                    isPending: true,
                                  )
                              );
                            }on CustomError catch(e){
                              errorDialog(context, e);
                            }
                          },
                          child: Text(state.changeStatus == ChangeStatus.isLoading? 'PATIENTEZ...' : 'CONFIRMER'),
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
                        ChangeTransactionForm(),
                      ],
                    ),
                    isActive: currentStep>=0
                ),
                Step(title: Text("Confirmez la transaction :", style: kTextBold,), content: Column(
                  children: [
                    ChangeValidationScreen(),
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

}
