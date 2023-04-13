import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/utils/utils.dart';

class CustomNoData extends StatelessWidget {
  const CustomNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.noDataImage, width: 230, height: 230),
          Text('Pas des données', style: TextStyle(fontWeight: bold, fontSize: 16),),
        ],
      ),
    );
  }
}
