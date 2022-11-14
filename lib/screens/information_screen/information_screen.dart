import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);
   static const String routeName = '/InformationScreen';
   static Route route (){
     return MaterialPageRoute(
       settings: RouteSettings(name: routeName),
         builder: (context)=> InformationScreen());
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Informations'),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('MES Pièces est une entreprise multisectorielle à mission de facilitarion financière sans frontières en temps et espace.'),
              SizedBox(height: 15,),
              Text('De cela nous offrons comme service:\n- Achat, vente, swap et payement de service CRYPTOGRAPHIQUE.\n- Publicité, marketing et vente des produits et billets.'),
              SizedBox(height: 15,),
              Text('Nous vous facilitons à acceder à tout exigence financière sans frontières au language de votre monnaie locale'),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('Developpé par Techy Ahead'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
