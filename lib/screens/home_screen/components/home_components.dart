import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/home_screen/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils.dart';

class HomeComponents extends StatelessWidget {
  const HomeComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 30,),),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 0,
              color: Colors.blue[50],
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //  padding: EdgeInsets.only(left: 20, top: 10, bottom: 30),
                  child: Text("Nouvelles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: primary), textAlign: TextAlign.center,),),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20,),
              AdvertisingContainer(),
              SizedBox(height: 40,),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                    elevation: 0,
                    color: Colors.blue[50],
                    child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text("Crypto disponibles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: primary), textAlign: TextAlign.center,))),
              ),
              SizedBox(height: 15,),
              CryptoAvailableListView(),
            ],
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 35,),),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 0,
              color: Colors.blue[50],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Taux de change", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: primary), textAlign: TextAlign.center,)),
            ),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index){
            return ListTransactions(
              initialMoneyType: 'ETH',
              finalMoneyType: 'BTC',
              amount: '38\$',
            );
          }, childCount: 5),
          ),
      ],
    );
  }
}
