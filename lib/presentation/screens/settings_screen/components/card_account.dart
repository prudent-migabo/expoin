import 'package:flutter/material.dart';
import 'package:expoin/presentation/screens/settings_screen/components/components.dart';

class CardAccount extends StatelessWidget {
   CardAccount({Key? key, this.onChangePassword, this.onDeleteAccount, this.onUpdatePhone}) : super(key: key);

  VoidCallback? onChangePassword;
  VoidCallback? onDeleteAccount;
  VoidCallback? onUpdatePhone;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            CustomListTile(subject: 'Changer le mot de passe', onTap: onChangePassword,),
            CustomDivider(),
            CustomListTile(subject: 'Mise à jour numéro de contact', onTap: onUpdatePhone,),
            CustomDivider(),
            CustomListTile(subject: 'Supprimer son compte', onTap: onDeleteAccount,),
            // CustomDivider(),
            // CustomListTile(subject: 'Deconnexion', onTap: onLogout,),
          ],
        ),
      ),
    );
  }
}
