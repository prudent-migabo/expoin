import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:intl/intl.dart';

class CashInHistoric extends StatelessWidget {
   CashInHistoric({Key? key}) : super(key: key);
  final CashInRepository _repository = CashInRepository();

  // var format = DateFormat.yMd('ar');
  // var dateString = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CashInModel>>(
        stream: _repository.getListCashInOrdered(),
        builder: (context, snapshot) {
          List<CashInModel>? listCashInModel = snapshot.data;
          if (!snapshot.hasData || listCashInModel!.isEmpty){
            return Center(child: CustomNoData());
          }
          else if (snapshot.hasError){
            errorDialog(context, content: snapshot.error.toString());
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listCashInModel.length,
              itemBuilder: (context, index) {
                final data = listCashInModel[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CashInDetailsScreen(
                      name: data.userName,
                      status: data.isPending,
                      amountToReceive: data.amountToReceive,
                      amountToSend: data.amountToSend,
                      cryptoType: data.cryptoType,
                      hashNumber: data.hashNumber,
                      mobileType: data.mobileType,
                      transactionID: data.transactionID,
                      boutiqueName: data.boutiqueName,
                    )));
                    },
                  child: Card(
                    child: ListTile(
                      title: Text(data.userName!, style: TextStyle(fontWeight: bold),),
                      subtitle: Text('${data.cryptoType} - ${data.mobileType}', style: TextStyle(fontSize: 13),),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          children: [
                            Expanded(child: CardPendingStatus(
                              text: data.isPending == true ? 'En attente' : 'Approuvé',
                              color: data.isPending == true ? Colors.red : Colors.green,
                            )),
                            Text('00:00', style: TextStyle(fontSize: 12),),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
    );
  }
}
