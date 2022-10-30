import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';

class HistoricComponents extends StatefulWidget {
  const HistoricComponents({Key? key}) : super(key: key);

  @override
  State<HistoricComponents> createState() => _HistoricComponentsState();
}

class _HistoricComponentsState extends State<HistoricComponents> {
  @override
  Widget build(BuildContext context) {
    Future logOut() async{
      await context.read<AuthRepository>().signOutUSer();
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  backgroundColor: kMainColor,
                  leading: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                        },
                        child: Icon(Icons.arrow_back_rounded)),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        const Text(
                          'Historique',
                          style: headerTitle,
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  expandedHeight: 120,
                  bottom:  TabBar(
                    // labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorWeight: 2,

                    tabs: [
                      Tab(
                        child: Text("ACHAT", style: kTextBold.copyWith(fontSize: 13),
                        ),
                      ),
                      Tab(
                        child: Text("VENTE", style: kTextBold.copyWith(fontSize: 13),),
                      ),
                      Tab(
                        child: Text("CHANGE", style: kTextBold.copyWith(fontSize: 13),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
              children: [
                CashInHistoricScreen(),
                CashOutHistoricScreen(),
                ChangeHistoricScreen(),
              ]),
        ),
      ),
    );
  }
}
