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

  @override
  void initState() {
    repository.getPinCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
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
      child: StreamBuilder<UserModel>(
          stream: ProfileRepository().getUserModel(),
          builder: (context, snapshot) {
            UserModel? userModel = snapshot.data;
            if (!snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              });

            } else if (snapshot.hasError) {
              errorDialog(context, content: snapshot.error.toString());

            } else if (userModel!.role != 'client') {
              errorDialog(context,
                  content:
                      "Désolé vous n'avez pas de compte client dans MesPieces, veuillez vous inscrire svp");
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              });

            } else if (userModel.isBlocked! == true) {
              errorDialog(context, content: "Désolé votre compte est actuellement bloqué");
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              });

            } else if (userModel.isDeleted! == true){
              errorDialog(context, content: "Désolé vous n'avez plus de compte sur MesPièces, veuillez en creer un svp!");
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              });
            }
            return Scaffold(
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
            );
          }),
    );
  }
}
