import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/presentation/screens/settings_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/SettingsScreen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final MesPiecesBloc _bloc = MesPiecesBloc();

  _logout() {
    _bloc.add(SignOutEvent());
  }

  _onSuppressAccount(){
    _bloc.add(DeleteUserEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {

        if(state is UserDeleted){
          successToast(message: 'Compte supprimé');
          _logout();
          // Navigator.pushNamedAndRemoveUntil(
          //     context, LoginScreen.routeName, (route) => false);
        }
        else if (state is ErrorState){
          errorDialog(context, content: state.message);
        } else if (state is LoadingState){
           CircularProgressIndicator();
        } else if (state is NoNetworkState){
          noNetworkToast(context);
        } else if (state is UserLoggedOut) {
          successToast(message: 'Deconnecté avec succès');
          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: mainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15,),
              CardProfile(),
              SizedBox(height: 30,),
              Text('Gestion de compte',
                style: TextStyle(fontWeight: bold, fontSize: 17),),
              SizedBox(height: 10,),
              CardAccount(
                onChangePassword: (){
                  Navigator.pushNamed(context, ChangePasswordScreen.routeName);
                },
                onDeleteAccount: (){
                  suppressDialog(context, content: 'Etes-vous sûr de vouloir supprimer votre compte?', title: 'Suppression de compte',
                    onPressed: _onSuppressAccount,
                  );
                },
                onUpdatePhone: (){
                  Navigator.pushNamed(context, UpdatePhoneScreen.routeName);
                },
              ),
              SizedBox(height: 20,),
              Text('Autres', style: TextStyle(fontWeight: bold, fontSize: 17),),
              SizedBox(height: 10,),
              CardOthers(
                onUpdatePinCode: (){
                  Navigator.pushNamed(context, UpdatePinCodeScreen.routeName);
                },
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: (){
                    suppressDialog(context, content: 'Etes-vous sûr de vouloir vous deconnecter?', title: 'Déconnexion',
                      onPressed: _logout,
                    );
                  },
                  child: Text('Deconnexion'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


