import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/screens/calculator_screen/components/components.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);
  static const String routeName = "/CalculatorScreen";

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context)=> CalculatorScreen());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            leading: Container(
              margin: EdgeInsets.only(top: 20),
              child: GestureDetector(
                  onTap: (){
                    //Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                  },
                  child: Icon(Icons.arrow_back_rounded)),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text("Calculatrice", style: sliverAppbarTitle,),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  child: Text("ACHAT", style: GoogleFonts.dmSans(fontWeight: bold, fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text("VENTE", style: GoogleFonts.dmSans(fontWeight: bold, fontSize: 14)),
                ),
                Tab(
                  child: Text("CHANGE", style: GoogleFonts.dmSans(fontWeight: bold, fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
            children: [
          CashIn(),
          CashOut(),
          Change(),
        ]),
      ),
    );
  }
}
