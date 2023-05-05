import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class DashBoardDetailsScreen extends StatefulWidget {
  static const String routeName = '/DashBoardDetailsScreen';
   DashBoardDetailsScreen({Key? key, this.boutiqueID, this.boutiqueName, this.boutiquePhone}) : super(key: key);
   String? boutiqueID;
   String? boutiqueName;
   String? boutiquePhone;

  @override
  State<DashBoardDetailsScreen> createState() => _DashBoardDetailsScreenState();
}

class _DashBoardDetailsScreenState extends State<DashBoardDetailsScreen> {
  final InformationRepository _repository = InformationRepository();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: SingleChildScrollView(
        padding: mainPadding,
        child: Column(
          children: [
            CustomAppbar(title: widget.boutiqueName!),
            StreamBuilder<List<CryptoModel>>(
              stream: _repository.getListOfActivesCrypto(widget.boutiqueID!),
              builder: (context, snapshot) {
                List<CryptoModel>? listCryptoModel = snapshot.data;
                if (!snapshot.hasData || listCryptoModel!.isEmpty){
                  return Center(child: CustomNoData());
                } else if (snapshot.connectionState == ConnectionState.waiting){
                  return Text('En attente...');
                }
                else if (snapshot.hasError){
                  errorDialog(context, content: snapshot.error.toString());
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listCryptoModel.length,
                    itemBuilder: (context, index) {
                      var data = listCryptoModel[index];
                      return InkWell(
                        onTap: (){
                            MesPiecesBloc.selectedCryptoName = data.name!;
                          Navigator.pushNamed(context, TransactionScreen.routeName);
                        },
                        child: Card(
                          margin: EdgeInsets.only(top: 2),
                          child: ListTile(
                            leading: CircleAvatar(radius: 20, backgroundImage: AssetImage(cryptoImageSelector(data.name!)),),
                            title: Text(data.name!, style: GoogleFonts.dmSans(fontSize: 14),),
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
            ),
          ],
        ),
      ),
    );
  }
}
