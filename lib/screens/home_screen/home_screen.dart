import 'package:expoin/screens/home_screen/components/components.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/HomeScreen";
  static Route route(){
    return MaterialPageRoute(builder: (context)=> HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(100),
      //   child: AppBar(
      //     title: Text("Porte-feuille", style: headerTitle),
      //   ),
      // ),
      body: HomeComponents(),
    );
  }
}
