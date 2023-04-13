import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/presentation/screens/register_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/presentation/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = '/ForgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final MesPiecesBloc _bloc = MesPiecesBloc();
  final TextEditingController _email = TextEditingController();

  _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    _bloc.add(ForgotPassword(email: _email.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ForgottenPasswordReset) {
          alert(context, content: 'Un email de reinitialisation a ete envoyé, veillez consultez votre boite mail pour reinitialiser votre mot de passe', title: 'Reinitialisation');
        } else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20,),
                AuthHeaderWithArrow(text: 'Recupération du mot de passe',),
                SizedBox(height: 25,),
                Text('Veillez saisir votre adresse mail',
                  style: TextStyle(fontSize: 15),),
                SizedBox(height: 10,),
                emailField(
                  controller: _email,
                ),
                SizedBox(height: 20,),
                BlocBuilder<MesPiecesBloc, MesPiecesState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    return CustomButton(
                        text: state is LoadingState ? "Patientez..." : "Soumettre", onPressed: state is LoadingState ? (){} : _onSubmit);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
