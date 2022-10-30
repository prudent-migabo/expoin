import 'package:expoin/screens/home_screen/components/components.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/HomeScreen";
  static Route route(){
    return MaterialPageRoute(builder: (context)=> HomeScreen());
  }
  final Uri whatsapp_url = Uri.parse("https://wa.me/message/X4KA5THVWWRMO1");

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_launchUrl(whatsapp_url),
        backgroundColor: Colors.green,
        child: Icon(FontAwesomeIcons.whatsapp, color: Colors.white,),
      ),
      body: HomeComponents(),
    );
  }
}
