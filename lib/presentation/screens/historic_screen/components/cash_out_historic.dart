import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class CashOutHistoric extends StatelessWidget {
   CashOutHistoric({Key? key}) : super(key: key);
   final CashOutRepository _repository = CashOutRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CashOutModel>>(
        stream: _repository.getListCashOutOrdered(),
        builder: (context, snapshot) {
          List<CashOutModel>? listCashOutModel = snapshot.data;
          if (!snapshot.hasData || listCashOutModel!.isEmpty){
            return Center(child: CustomNoData());
          }
          else if (snapshot.hasError){
            errorDialog(context, content: snapshot.error.toString());
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listCashOutModel.length,
              itemBuilder: (context, index) {
                final data = listCashOutModel[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CashOutDetailsScreen(
                      name: data.userName,
                      status: data.isPending,
                      amountToReceive: data.amountToReceive,
                      amountToSend: data.amountToSend,
                      cryptoType: data.cryptoType,
                      phoneNumber: data.phoneMobileNumber,
                      transactionID: data.transactionID,
                      boutiqueName: data.boutiqueName,
                    )));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(data.userName!, style: TextStyle(fontWeight: bold),),
                      subtitle: Text('${data.cryptoType} - ${data.phoneMobileNumber}', style: GoogleFonts.dmSans(fontSize: 13),),
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
