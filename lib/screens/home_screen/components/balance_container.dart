import 'package:expoin/utils/constant.dart';
import 'package:flutter/material.dart';

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(15.0),
      width: width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kMainColor,
      ),
      child: Column(
        children: [
          Text("Mon Porte-Feuille", style: fontColor1, textAlign: TextAlign.center,),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Balance en mobile", style: fontColor1,),
                  SizedBox(height: 10,),
                  Text("333 456\$", style: fontColor2,),
                  Text("34 000Fc", style: fontColor2,),
                ],
              ),
              Column(
                children: [
                  Text("Balance en crypto", style: fontColor1,),
                  SizedBox(height: 10,),
                  Text("333 BTC", style: fontColor2,),
                  Text("34 ETH", style: fontColor2,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
