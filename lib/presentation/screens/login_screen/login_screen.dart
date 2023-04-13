import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/Login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MesPiecesBloc? _bloc;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isVisible = false;
  final BoutiqueRepository _repository = BoutiqueRepository();
  Map data = {};

  @override
  void initState() {
    _bloc = MesPiecesBloc();
    //_repository.getListBoutique();
    super.initState();
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    _bloc!.add(LoginEvent(
      email: _email.text.trim(),
      password: _password.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme
        .of(context)
        .colorScheme
        .primary;
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UserLoggedIn) {
          Navigator.pushNamed(context, PinVerificationScreen.routeName);
          successToast(message: 'Connection reussie');
        }
        else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Mes Pièces",
                      style: TextStyle(
                          color: primary,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Se Connecter",
                      style: TextStyle(
                          color: primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Text(
                      "Connectez-vous pour gérer votre compte...",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AuthLabel('Email'),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ce champ ne peut être vide";
                        } else if (!value.contains("@")) {
                          return "Email mal composé";
                        }
                      },
                      onChanged: (val) => _email.text,
                    ),
                    AuthLabel('Mot de passe'),
                    TextFormField(
                      controller: _password,
                      obscureText: isVisible ? false : true,
                      decoration: textFieldAuthDecoration(
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Ce champ ne peut être vide";
                        } else if (val.length < 6) {
                          return "Mot de passe trop court";
                        }
                      },
                      onChanged: (val) => _password.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                          },
                          child: Text(
                            "Mot de passe oublié?",
                            style: TextStyle(color: primary, fontSize: 13),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<MesPiecesBloc, MesPiecesState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        return CustomButton(
                            text: state is LoadingState
                                ? "Patientez..."
                                : "Se connecter",
                            onPressed: state is LoadingState ? (){} : _onSubmit,
                              //print('000000000000000000000000000000000000000000000000000000000000000000000000000 ${MesPiecesBloc.boutiquesInfo}');
                              // if( _email.text == data['email']){
                              //   print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| ${data['email']}');
                              //   errorDialog(context, content: 'Ce compte appartient à et donc ne peut pas se connecter en tant que client');
                              //   _email.clear();
                              //   _password.clear();
                              // }
                              // _onSubmit();
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomSignUpButton(
                      text: 'Créer un compte',
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}