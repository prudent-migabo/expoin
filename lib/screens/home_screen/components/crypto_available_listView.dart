import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CryptoAvailableListView extends StatelessWidget {
  const CryptoAvailableListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          ImagesHomePage(image: AssetImage(Assets.btc),),
          SizedBox(width: 25,),
          ImagesHomePage(image: AssetImage(Assets.ada),),
          SizedBox(width: 25,),
          ImagesHomePage(image: AssetImage(Assets.eth),),
          SizedBox(width: 25,),
          ImagesHomePage(image: AssetImage(Assets.bnb),),
          SizedBox(width: 25,),
          ImagesHomePage(image: AssetImage(Assets.usdt),),
        ],
      ),
    );
  }
}
