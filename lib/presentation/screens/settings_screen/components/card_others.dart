import 'package:flutter/material.dart';
import 'package:expoin/presentation/screens/settings_screen/components/components.dart';

class CardOthers extends StatelessWidget {
   CardOthers({Key? key, this.onUpdatePinCode}) : super(key: key);

   VoidCallback? onUpdatePinCode;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            CustomListTile(subject: 'Mode nuit'),
            CustomDivider(),
            CustomListTile(subject: "Changer le code pin de l'application", onTap: onUpdatePinCode,),
            CustomDivider(),
            CustomListTile(subject: "Langue"),
          ],
        ),
      ),
    );
  }
}