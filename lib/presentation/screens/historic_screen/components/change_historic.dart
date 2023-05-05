import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class ChangeHistoric extends StatelessWidget {
   ChangeHistoric({Key? key}) : super(key: key);
  final ChangeRepository _repository = ChangeRepository();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChangeModel>>(
        stream: _repository.getListChangeOrdered(),
        builder: (context, snapshot) {
          List<ChangeModel>? listCashChangeModel = snapshot.data;
          if (!snapshot.hasData || listCashChangeModel!.isEmpty){
            return Center(child: CustomNoData());
          }
          else if (snapshot.hasError){
            errorDialog(context, content: snapshot.error.toString());
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listCashChangeModel.length,
              itemBuilder: (context, index) {
                final data = listCashChangeModel[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeDetailsScreen(
                      name: data.userName,
                      status: data.isPending,
                      amountToReceive: data.amountToReceive,
                      amountToSend: data.cryptoAmountToSend,
                      transactionID: data.transactionMessage,
                      cryptoTypeToSend: data.cryptoTypeToSend,
                      cryptoTypeToReceive: data.cryptoTypeToReceive,
                      boutiqueName: data.boutiqueName,
                    )));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(data.userName!, style: TextStyle(fontWeight: bold),),
                      subtitle: Text('${data.cryptoTypeToSend} - ${data.cryptoTypeToReceive}', style: TextStyle(fontSize: 13),),
                      trailing: Column(
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
                );
              });
        }
    );
  }
}
