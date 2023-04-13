import 'package:flutter/material.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class ListBoutiques extends StatefulWidget {
  const ListBoutiques({Key? key}) : super(key: key);

  @override
  State<ListBoutiques> createState() => _ListBoutiquesState();
}

class _ListBoutiquesState extends State<ListBoutiques> {
  final InformationRepository _repository = InformationRepository();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BoutiqueModel>>(
      stream: _repository.getListBoutique(),
      builder: (context, snapshot) {
        List<BoutiqueModel>? listBoutiqueModel = snapshot.data;
        if (!snapshot.hasData || listBoutiqueModel!.isEmpty){
          return Center(child: CustomNoData());
        } else if (snapshot.connectionState == ConnectionState.waiting){
          return Text('En attente...');
        }
        else if (snapshot.hasError){
          errorDialog(context, content: snapshot.error.toString());
        }
        return ListView.builder(
            padding: EdgeInsets.only(top: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listBoutiqueModel.length,
            itemBuilder: (context, index) {
              var data = listBoutiqueModel[index];
              MesPiecesBloc.boutiqueID = data.docID!;
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoardDetailsScreen(
                    boutiqueName: data.name,
                    boutiqueID: data.docID,
                    boutiquePhone: data.phone,
                  )));
                },
                child: Card(
                  margin: EdgeInsets.only(top: 3),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(data.name!),
                        Icon(Icons.upload_file_rounded, size: 15),
                      ],
                    ),
                    trailing: Text('-', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: bold),),
                  ),
                ),
              );
            });
      }
    );
  }
}
