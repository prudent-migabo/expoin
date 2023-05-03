import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class CashInScreen extends StatefulWidget {
  const CashInScreen({Key? key}) : super(key: key);

  @override
  State<CashInScreen> createState() => _CashInScreenState();
}

class _CashInScreenState extends State<CashInScreen> {
  final MesPiecesBloc _bloc = MesPiecesBloc();
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    var state = context.watch<CashInProvider>().state;
    var cashInModelState = context.watch<SaveCashInDetailsController>().cashInModel;
    var userName = context.watch<UserModel>().lastName;

    if(state.cashInStatus == CashInStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        alert(context, title: 'Super', content: "Votre requête est soumise avec succès",
          onPressed: (){
          Navigator.pop(context);
          }
        );
        context.read<CashInProvider>().initialState();
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
                                    boutiqueID: MesPiecesBloc.selectedBoutiqueID,
                                    boutiqueName: MesPiecesBloc.selectedBoutiqueName,
                                  ));
                            } on CustomError catch(e){
                              errorDialog(context, content: e.message);
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
                    title: const Text("Demarrez la transaction en toute securité :", style: textStyleBold,),
                    content: CashInTransactionScreen(),
                    isActive: currentStep>=0,
                ),
                Step(title: const Text("Confirmez la transaction :", style: textStyleBold,), content: CashInValidationScreen(),
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