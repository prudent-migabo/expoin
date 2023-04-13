import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class TransactionScreen extends StatefulWidget {
  static const String routeName = '/TransactionScreen';

  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final MesPiecesBloc _bloc = MesPiecesBloc();

  _logout() {
    _bloc.add(SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UserLoggedOut) {
          successToast(message: 'Deconnecté');
          Navigator.pushNamed(context, LoginScreen.routeName);
        } else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: true,
                    backgroundColor: primary,
                    leading: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, BottomNavigationScreen.routeName, (route) => false);
                          },
                          child: Icon(Icons.arrow_back_rounded)),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          Text(
                            MesPiecesBloc.selectedBoutiqueName,
                            style: sliverAppbarTitle.copyWith(fontSize: 23),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.only(right: 15, top: 20),
                        child: GestureDetector(
                          onTap: () {
                            suppressDialog(context,
                                title: "Deconnexion",
                                content:
                                    "Etes-vous sûr de vouloir vous déconnecter ?",
                                onPressed: _logout,);
                          },
                          child: Icon(Icons.logout),
                        ),
                      )
                    ],
                    centerTitle: true,
                    expandedHeight: 120,
                    bottom: TabBar(
                      // labelColor: Colors.white,
                      indicatorColor: Colors.white,
                      indicatorWeight: 2,

                      tabs: [
                        Tab(
                          child: Text(
                            "ACHAT",
                            style: GoogleFonts.dmSans(
                                fontWeight: bold, fontSize: 14),
                          ),
                        ),
                        Tab(
                          child: Text("VENTE",
                              style: GoogleFonts.dmSans(
                                  fontWeight: bold, fontSize: 14)),
                        ),
                        Tab(
                          child: Text("CHANGE",
                              style: GoogleFonts.dmSans(
                                  fontWeight: bold, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            body: TabBarView(children: [
              CashInScreen(),
              CashOutScreen(),
              ChangeScreen(),
            ]),
          ),
        ),
      ),
    );
  }
}
