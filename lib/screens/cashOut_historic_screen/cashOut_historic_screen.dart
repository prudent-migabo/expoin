import 'package:expoin/models/models.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashOut_historic_screen/components/components.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class CashOutHistoricScreen extends StatelessWidget {
  const CashOutHistoricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder<List<CashOutModel>>(
          stream: context.watch<CashOutHistoricRepository>().getListCashOut(),
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
                  return Card(
                    elevation: 0,
                    margin: EdgeInsets.only(bottom: 3),
                    color: Colors.blueGrey[50],
                    child: ListTile(
                      title: Text(data.userName!,),
                      subtitle: Text("A envoyé : ${data.amountToSend}\$, Veut recevoir : ${data.amountToReceive}\$", style: kTextBold),
                      trailing: RoundedCardTileTrans(
                        text: data.isPending! ?'En attente' : 'Approuvé',
                        color: data.isPending! ? Colors.red.shade800 : Colors.green,
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CashOutHistoricDetails(
                          userName: data.userName,
                          cryptoType: data.cryptoType,
                          transactionMessage: data.transactionID,
                          cryptoAmountToSend: data.amountToSend,
                          phoneNumber: data.phoneMobileNumber,
                        )));
                      },
                      onLongPress: () async{
                        alertDialog(context, content: 'Etes-vous sur de vouloir supprimer?', title: 'Suppression',
                            onPressed: () async{
                             await context.read<CashOutHistoricRepository>().deleteCashOutHistoric(data.docID!);
                             Navigator.pop(context);
                            });
                      },
                    ),
                  );
                });
          }
      ),
    );
  }
}
