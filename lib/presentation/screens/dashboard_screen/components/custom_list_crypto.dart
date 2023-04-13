import 'package:flutter/material.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/assets.dart';
import 'package:expoin/utils/utils.dart';

class CustomListCrypto extends StatelessWidget {
   CustomListCrypto({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: ListHelper.cryptosCategories.length,
          itemBuilder: (context, index){
          var data = ListHelper.cryptosCategories[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardCryptoDetailsScreen(
                cryptoName: data,
              )));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: primary, width: 0.4),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Image.asset(cryptoImageSelector(data), height: 30, width: 30,),
              ),
            ),
          );
      }),
    );
  }
}
