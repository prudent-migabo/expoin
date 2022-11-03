import 'package:expoin/models/models.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/change_historic_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeHistoricScreen extends StatefulWidget {
  const ChangeHistoricScreen({Key? key}) : super(key: key);

  @override
  State<ChangeHistoricScreen> createState() => _ChangeHistoricScreenState();
}

class _ChangeHistoricScreenState extends State<ChangeHistoricScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder<List<ChangeModel>>(
          stream: context.watch<ChangeRepository>().getListChange(),
          builder: (context, snapshot) {
            List<ChangeModel>? listChange = snapshot.data;
            if(!snapshot.hasData || listChange!.isEmpty){
              return Center(child: Text('Pas des données...'),);
            } else if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Chargement...'),);
            }
            else if(snapshot.hasError){
              errorDialog(context, CustomError(code: 'code', message: snapshot.error.toString(), plugin: 'plugin'));
            }
            return StreamBuilder<List<ChangeModel>>(
              stream: context.watch<ChangeRepository>().getListChangeOrdered(),
              builder: (context, snapshot) {
                List<ChangeModel>? listChange = snapshot.data;
                if(!snapshot.hasData || listChange!.isEmpty){
                  return Center(child: Text('Pas des données...'),);
                } else if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Chargement...'),);
                }
                else if(snapshot.hasError){
                  errorDialog(context, CustomError(code: 'code', message: snapshot.error.toString(), plugin: 'plugin'));
                }
                return ListView.builder(
                    itemCount: listChange.length,
                    itemBuilder: (context, index){
                      var data = listChange[index];
                      return CardTileHistoric(
                          userName: data.userName!,
                          amountToSend: data.cryptoAmountToSend,
                          amountToReceive: data.amountToReceive!,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeHistoricDetails(
                              userName: data.userName,
                              cryptoTypeToSend: data.cryptoTypeToSend,
                              cryptoTypeToReceive: data.cryptoTypeToReceive,
                              cryptoAmountToSend: data.cryptoAmountToSend,
                              hashNumber: data.hashNumber,
                              transactionMessage: data.transactionMessage,
                            )));
                          },
                          onLongPressed: () async{
                            alertDialog(context, content: 'Etes-vous sur de vouloir supprimer?', title: 'Suppression',
                                onPressed: () async{
                                  await context.read<ChangeRepository>().deleteChangeHistoric(data.docID!);
                                  Navigator.pop(context);
                                });
                          },
                          isPending: data.isPending!,
                      );
                    });
              }
            );
          }
      ),
    );
  }
}


