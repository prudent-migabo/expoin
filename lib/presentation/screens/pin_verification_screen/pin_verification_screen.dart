import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:pinput/pinput.dart';

class PinVerificationScreen extends StatefulWidget {
  static const String routeName = '/PinVerificationScreen';

  const PinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinput = TextEditingController();
  final MesPiecesBloc _bloc = MesPiecesBloc();
  InformationRepository repository = InformationRepository();

  final _key = GlobalKey<FormState>();

  _onSubmit() {
    if (!_key.currentState!.validate()) return;
    _bloc.add(PinVerificationEvent(code: _pinput.text));
  }

  _onLogout() {
    _bloc.add(SignOutEvent());
  }

  _logout(){
    AuthRepository().signOut();
    print('User logged out');
  }

  _onWrapperVerification(){
    _bloc.add(WrapperEvent());
  }

  @override
  void initState() {
    repository.getPinCode();
    _onWrapperVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is WrapperState){
          if (state.role != 'client'){
            _onLogout();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            errorDialog(context, content: "Vous n'avez pas de compte client chez MesPieces, veuillez en creer un svp.",
              barrierDismissible: true,
              child: Container(),
            );
          } else if (state.isBlocked != false){
            _onLogout();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            errorDialog(context, content: "Désolé vous n'avez pas de compte actif chez MesPieces, il a été bloqué. Veuillez contacter l'administration.",
              barrierDismissible: true,
              child: Container(),
            );
          }  else if (state.isDeleted != false){
            _onLogout();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            errorDialog(context, content: "Désolé vous n'avez pas de compte actif chez MesPieces, il a été supprimé. Veuillez en creer un autre svp.",
              barrierDismissible: true,
              child: Container(),
            );
            // print(FirebaseAuth.instance.currentUser!.email);
          }  else if (state.email != FirebaseAuth.instance.currentUser!.email){
            _onLogout();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            errorDialog(context, content: "Désolé vous n'avez pas de compte actif chez MesPieces. Veuillez en creer un autre svp.",
              barrierDismissible: true,
              child: Container(),
            );
          }
          null;
        }
        if (state is PinVerified) {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavigationScreen.routeName, (route) => false);
          successToast(message: 'Bienvenue');
          _pinput.clear();
        } else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: mainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 25,
              ),
              AuthHeaderWithArrow(
                text: 'Entrez votre code de sécurité',
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _key,
                child: Pinput(
                  controller: _pinput,
                  length: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  defaultPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? "Ne peut pas etre null" : null,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              BlocBuilder<MesPiecesBloc, MesPiecesState>(
                bloc: _bloc,
                builder: (context, state) {
                  return CustomButton(
                      text: state is LoadingState
                          ? 'Patientez...'
                          : 'Valider',
                      onPressed:
                      state is LoadingState ? () {} : _onSubmit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

