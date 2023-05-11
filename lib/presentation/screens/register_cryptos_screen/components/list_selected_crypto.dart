import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class ListSelectedCrypto extends StatefulWidget {
  ListSelectedCrypto({Key? key, required this.cryptoType}) : super(key: key);

  String cryptoType;

  @override
  State<ListSelectedCrypto> createState() => _ListSelectedCryptoState();
}

class _ListSelectedCryptoState extends State<ListSelectedCrypto> {
  InformationRepository _repository = InformationRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WalletAddressModel>>(
        stream: _repository.getListWalletAddressModel(),
        builder: (context, snapshot) {
          List<WalletAddressModel>? listCryptoModel = snapshot.data;
          if (!snapshot.hasData || listCryptoModel!.isEmpty){
            return CustomNoData();
          } else if (snapshot.hasError){
            errorDialog(context, content: snapshot.error.toString());
          }
          return ListView.builder(
              padding: EdgeInsets.only(top: 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listCryptoModel.length,
              itemBuilder: (context, index){
                var data = listCryptoModel[index];
                return InkWell(
                  onLongPress: (){
                    suppressDialog(context, content: 'Etes vous sûre de vouloir supprimer?', title: 'Suppression', onPressed: (){
                      _repository.deleteCrypto(data.id!);
                      Navigator.pop(context);
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 15, backgroundImage: AssetImage(cryptoImageSelector(data.name!)),),
                      title: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(data.name!, style: GoogleFonts.dmSans(fontWeight: bold, fontSize: 14))),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text('Wallet : ${data.walletAddress!}'),
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
