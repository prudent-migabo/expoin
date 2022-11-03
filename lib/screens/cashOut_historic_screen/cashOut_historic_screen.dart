import 'package:expoin/models/models.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashOut_historic_screen/components/components.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class CashOutHistoricScreen extends StatefulWidget {
  const CashOutHistoricScreen({Key? key}) : super(key: key);

  @override
  State<CashOutHistoricScreen> createState() => _CashOutHistoricScreenState();
}

class _CashOutHistoricScreenState extends State<CashOutHistoricScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder<List<CashOutModel>>(
          stream: context.watch<CashOutRepository>().getListCashOut(),
          builder: (context, snapshot) {
            List<CashOutModel>? listCashOut = snapshot.data;
            if(!snapshot.hasData || listCashOut!.isEmpty){
              return Center(child: Text('Pas des données...'),);
            } else if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Chargement...'),);
            }
            else if(snapshot.hasError){
              errorDialog(context, CustomError(code: 'code', message: snapshot.error.toString(), plugin: 'plugin'));
            }
            return StreamBuilder<List<CashOutModel>>(
              stream: context.watch<CashOutRepository>().getListCashOutOrdered(),
              builder: (context, snapshot) {
                List<CashOutModel>? listCashOut = snapshot.data;
                if(!snapshot.hasData || listCashOut!.isEmpty){
                  return Center(child: Text('Pas des données...'),);
                } else if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Chargement...'),);
                }
                else if(snapshot.hasError){
                  errorDialog(context, CustomError(code: 'code', message: snapshot.error.toString(), plugin: 'plugin'));
                }
                return ListView.builder(
                    itemCount: listCashOut.length,
                    itemBuilder: (context, index){
                      var data = listCashOut[index];
                      return CardTileHistoric(
                          userName: data.userName!,
                          amountToSend: data.amountToSend,
                          amountToReceive: data.amountToReceive!,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CashOutHistoricDetails(
                              userName: data.userName,
                              cryptoType: data.cryptoType,
                              transactionMessage: data.transactionID,
                              cryptoAmountToSend: data.amountToSend,
                              phoneNumber: data.phoneMobileNumber,
                            )));
                          },
                          onLongPressed: () async{
                            alertDialog(context, content: 'Etes-vous sur de vouloir supprimer?', title: 'Suppression',
                                onPressed: () async{
                                  await context.read<CashOutRepository>().deleteCashOutHistoric(data.docID!);
                                  Navigator.pop(context);
                                });
                          },
                          isPending: data.isPending!);
                    });
              }
            );
          }
      ),
    );
  }
}
