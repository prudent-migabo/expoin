import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/dialog_alerts.dart';
import 'package:provider/provider.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CashOutProvider>().state;
    final cashOutModelState = context.watch<SaveCashOutDetailsController>().cashOutModel;
    var userName = context.watch<UserModel>().lastName;

    if(state.cashOutStatus == CashOutStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        alert(context, title: 'Super', content: "Votre requete est soumise a l'administration avec succes, vous recevrez la suite dans une heure",
            onPressed: (){
              Navigator.pop(context);
            }
        );
        context.read<CashOutProvider>().initialState();
      });
    }

    return  Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: Stepper(
              elevation: 0,
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
                                  amountToReceive: context.read<CashOutCalculationProvider>().result.toString(),
                                  phoneMobileNumber: cashOutModelState.phoneMobileNumber,
                                  transactionID: cashOutModelState.transactionID,
                                  userName: userName,
                                  isPending: true,
                                  boutiqueID: MesPiecesBloc.selectedBoutiqueID,
                                ),
                              );
                            }on CustomError catch(e){
                              errorDialog(context, content: e.message);
                            }
                          },
                          child:  Text(state.cashOutStatus == CashOutStatus.isLoading?'PATIENTEZ...':'CONFIRMER'),
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
                  title: const Text("Demarrez la transaction en toute securité :", style: textStyleBold,),
                  content: CashOutTransactionScreen(),
                  isActive: currentStep>=0,
                ),
                Step(title: const Text("Confirmez la transaction :", style: textStyleBold,),
                    content: CashOutValidationScreen(),
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
