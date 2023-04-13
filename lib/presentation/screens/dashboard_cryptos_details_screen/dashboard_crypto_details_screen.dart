import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class DashBoardCryptoDetailsScreen extends StatefulWidget {
  static const String routeName = '/DashBoardCryptoDetailsScreen';
   DashBoardCryptoDetailsScreen({Key? key, this.cryptoName}) : super(key: key);

   String? cryptoName;

  @override
  State<DashBoardCryptoDetailsScreen> createState() => _DashBoardCryptoDetailsScreenState();
}

class _DashBoardCryptoDetailsScreenState extends State<DashBoardCryptoDetailsScreen> {
   final InformationRepository _repository = InformationRepository();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: SingleChildScrollView(
        padding: mainPadding,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios, size: 20,)),
                  SizedBox(width: 10,),
                  Text(widget.cryptoName!, style: TextStyle(fontSize: 17, fontWeight: bold),),
                ],
              ),
            ),

            StreamBuilder<List<BoutiqueModel>>(
              stream: _repository.getListOfFilteredBoutiques(boutiqueID: MesPiecesBloc.boutiqueID, cryptoName: widget.cryptoName),
              builder: (context, snapshot) {
                List<BoutiqueModel>? listBoutiqueModel = snapshot.data;
                if (!snapshot.hasData || listBoutiqueModel!.isEmpty){
                  return CustomNoData();
                } else if (snapshot.connectionState == ConnectionState.waiting){
                  return Text('En attente...');
                }
                else if (snapshot.hasError){
                  errorDialog(context, content: snapshot.error.toString());
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listBoutiqueModel.length,
                    itemBuilder: (context, index) {
                      var data = listBoutiqueModel[index];
                      return InkWell(
                        onTap: (){
                          //Navigator.pushNamed(context, TransactionScreen.routeName);
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 2),
                          child: ListTile(
                            title: Text(data.boutiqueName!, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: bold),),
                            subtitle: Row(
                              children: [
                                Icon(Icons.arrow_drop_up, color: primary,),
                                Text('10%', style: GoogleFonts.dmSans(fontSize: 12),),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_drop_down, color: Colors.yellow,),
                                Text('3%', style: GoogleFonts.dmSans(fontSize: 12),),
                              ],
                            ),
                            trailing: Text('\$ 0299', style: GoogleFonts.dmSans(fontWeight: bold, color: primary),),
                          ),
                        ),
                      );
                    });
              }
            )
          ],
        ),
      ),
    );
  }
}
