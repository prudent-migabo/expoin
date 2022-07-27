import 'package:expoin/screens/home_screen/components/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/HomeScreen";
  static Route route(){
    return MaterialPageRoute(builder: (context)=> HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeComponents(),
    );
  }
}
