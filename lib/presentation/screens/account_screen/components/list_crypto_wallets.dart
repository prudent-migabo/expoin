import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class ListCryptoWallets extends StatelessWidget {
   ListCryptoWallets({Key? key}) : super(key: key);
  final InformationRepository _repository = InformationRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WalletAddressModel>> (
      stream: _repository.getListWalletAddressModel(),
      builder: (context, snapshot){
        List<WalletAddressModel>? listWalletAddressModel = snapshot.data;
        if(!snapshot.hasData || listWalletAddressModel!.isEmpty){
          return Center(child: CustomNoData(),);
        } else if (snapshot.hasError){
          errorDialog(context, content: snapshot.error.toString());
        }
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 5),
            itemCount: listWalletAddressModel.length,
            itemBuilder: (context, index){
              var data = listWalletAddressModel[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailsScreen(
                    cryptoName: data.name,
                  )));
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(radius: 20, backgroundImage: AssetImage(cryptoImageSelector(data.name!),), backgroundColor: Colors.grey[100],),
                    title: Text(data.name!, style: GoogleFonts.dmSans(fontSize: 14),),
                    subtitle: Text('Wallet: ${data.walletAddress!}' ),
                  ),
                ),
              );
            });
      },
    );
  }
}
