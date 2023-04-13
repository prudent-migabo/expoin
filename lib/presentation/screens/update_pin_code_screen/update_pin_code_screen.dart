import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:pinput/pinput.dart';

class UpdatePinCodeScreen extends StatefulWidget {
  static const String routeName = '/UpdatePinCodeScreen';
   UpdatePinCodeScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePinCodeScreen> createState() => _UpdatePinCodeScreenState();
}

class _UpdatePinCodeScreenState extends State<UpdatePinCodeScreen> {
  final TextEditingController _pinput = TextEditingController();
  final MesPiecesBloc _bloc = MesPiecesBloc();
  final _key = GlobalKey<FormState>();

  _onSubmit() {
    if (!_key.currentState!.validate()) return;
    _bloc.add(UpdatePinCodeEvent(newPinCode: _pinput.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is PinCodeUpdated) {
          successToast(message: 'Code pin mise à jour avec succès');
          Navigator.pop(context);
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
                text: 'Modifier votre code de sécurité',
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'Saisissez le nouveau code de securité',
                style: TextStyle(fontWeight: bold, color: Colors.black54),
              ),
              SizedBox(height: 20,),
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
                  validator: (val) => val!.isEmpty
                      ? "Une valeur nulle ne peut etre sauvegardé"
                      : null,
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
                          : 'Mettre à jour',
                      onPressed: state is LoadingState ? () {} : _onSubmit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
