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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
            floating: true,
            bottom: PreferredSize(
              child: Container(),
              preferredSize: Size.fromHeight(35),
            ),
          title: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text("Porte-feuille", style: TextStyle(fontSize: 30)),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BalanceContainer(),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Text("Transactions effectuées", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,),
        ),
        StreamBuilder<List<CryptoToMobileModel>>(
            stream: context.watch<CryptoToMobileRepository>().getListCryptoToMobile(),
            builder: (context, snapshot){
              List<CryptoToMobileModel>? listCryptoToMobile = snapshot.data;
              if(!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Container(
                    child: Center(child: Text("Chargement..."),),
                  ),
                );
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return SliverToBoxAdapter(
                  child: Container(
                    child: Center(child: Text("Chargement..."),),
                  ),
                );
              } else if (snapshot.hasError){
                return SliverToBoxAdapter(
                  child: Container(
                    child: Center(child: Text("Chargement..."),),
                  ),
                );
              }
          return SliverList(delegate: SliverChildBuilderDelegate((context, index){
            var data = listCryptoToMobile![index];
            return ListTransactions(
              initialMoneyType: data.cryptoType,
              finalMoneyType: data.transactionID,
              amount: data.cryptoAmount,
            );
          }, childCount: listCryptoToMobile!.length));
        }),

      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child:
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //    // mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       SizedBox(height: 45,),
    //       Text("Expoin", style: headerTitle.copyWith(color: Colors.black, fontSize: 40),),
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: 0),
    //           child: Divider(color: Colors.black12, thickness: 1.0,)),
    //       BalanceContainer(),
    //       SizedBox(height: 20,),
    //       Expanded(
    //           child: Container(
    //             width: width,
    //               child: ListTransactions())),
    //     ],
    //   ),
    // );
  }
}
