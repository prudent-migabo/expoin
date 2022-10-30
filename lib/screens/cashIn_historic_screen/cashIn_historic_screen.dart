import 'package:expoin/models/models.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/cashIn_historic_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashInHistoricScreen extends StatefulWidget {
  const CashInHistoricScreen({Key? key}) : super(key: key);

  @override
  State<CashInHistoricScreen> createState() => _CashInHistoricScreenState();
}

class _CashInHistoricScreenState extends State<CashInHistoricScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder<List<CashInModel>>(
          stream: context.watch<CashInHistoricRepository>().getListCashIn(),
          builder: (context, snapshot) {
            List<CashInModel>? listCashIn = snapshot.data;
            if(!snapshot.hasData || listCashIn!.isEmpty){
              return Center(child: Text('Pas des données...'),);
            } else if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Chargement...'),);
            }
            else if(snapshot.hasError){
              errorDialog(context, CustomError(code: 'code', message: snapshot.error.toString(), plugin: 'plugin'));
            }
            return ListView.builder(
                itemCount: listCashIn.length,
                itemBuilder: (context, index){
                  var data = listCashIn[index];
                  return Card(
                    elevation: 0,
                    margin: EdgeInsets.only(bottom: 3),
                    color: Colors.blueGrey[50],
                    child: ListTile(
                      title: Text(data.userName!,),
                      subtitle: Text("A envoyé : ${data.amountToSend}\$, Veut recevoir : ${data.amountToReceive}\$", style: kTextBold),
                      trailing: RoundedCardTileTrans(
                        text: data.isPending! ? 'En attente' : "Approuvé",
                        color: data.isPending! ? Colors.red.shade800 : Colors.green,
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CashInHistoricDetails(
                          userName: data.userName,
                          cryptoType: data.cryptoType,
                          amountToSend: data.amountToSend,
                          amountToReceive: data.amountToReceive,
                          hashNumber: data.hashNumber,
                          mobileType: data.mobileType,
                          transactionContent: data.transactionID,
                        )));
                      },
                      onLongPress: () async{
                        alertDialog(context, content: 'Etes-vous sur de vouloir supprimer?', title: 'Suppression',
                            onPressed: () async{
                          await context.read<CashInHistoricRepository>().deleteCashInHistoric(data.docID!);
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
