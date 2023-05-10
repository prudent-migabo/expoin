import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({Key? key}) : super(key: key);

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {

  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangeProvider>().state;
    final changeModelState = context.watch<SaveChangeDetailsController>().changeModel;
    var userName = context.watch<UserModel>().lastName;

    if(state.changeStatus == ChangeStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        alert(context, title: 'Super', content: "Votre requete est soumise avec succès.",
            onPressed: (){
              Navigator.pop(context);
            },
          titleColor: Colors.green[600],
          actionBtnColor: Colors.green[600],
        );
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
                                    boutiqueName: MesPiecesBloc.selectedBoutiqueName,
                                    boutiqueID: MesPiecesBloc.selectedBoutiqueID,
                                  ),
                              );
                            }on CustomError catch(e){
                              errorDialog(context, content: e.message);
                            }
                          },
                          child: Text(state.changeStatus == ChangeStatus.isLoading?'PATIENTEZ...':'CONFIRMER'),
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
                    title: Text("Demarrez la transaction en toute securité :", style: textStyleBold,),
                    content: Column(
                      children: [
                        ChangeTransactionScreen(),
                      ],
                    ),
                    isActive: currentStep>=0
                ),
                Step(title: Text("Confirmez la transaction :", style: textStyleBold,), content: Column(
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
