import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/presentation/widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/ChangePasswordScreen';
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final MesPiecesBloc _bloc = MesPiecesBloc();
  bool isVisible = false;

  _onSubmit() {
    if(!_formKey.currentState!.validate()) return;
    _bloc.add(ChangePasswordEvent(newPassword: _controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
       if(state is PasswordChanged){
         successToast(message: 'Mot de passe modifié avec succès, essayez a votre prochaine reconnexion');
         _controller.clear();
       } else if (state is ErrorState){
         errorDialog(context, content: state.message);
         _controller.clear();
       } else if (state is NoNetworkState){
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
                height: 15,
              ),
              AuthHeaderWithArrow(
                text: 'Changement du mot de passe',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Saisissez le nouveau mot de passe',
                style: TextStyle(fontWeight: bold, color: Colors.black54),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  style: GoogleFonts.dmSans(fontSize: 14,),
                  controller: _controller,
                  obscureText: isVisible ? false : true,
                  decoration: textFieldAuthDecoration(
                    hintText: 'Nouveau mot de passe',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? Icon(
                        Icons.visibility_off_rounded,
                        color: Color(0xff004d99),
                        size: 20,
                      )
                          : Icon(
                        Icons.remove_red_eye_rounded,
                        color: Color(0xff004d99),
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) => value!.isEmpty? 'Une valeur null ne peut pas être envoyée' : null,
                ),
              ),
              SizedBox(
                height: 25,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
