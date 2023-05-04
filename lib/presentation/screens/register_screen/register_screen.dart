import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/presentation/screens/register_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';
import 'package:country_picker/country_picker.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/Register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  String? dateValue;
  String? dialCodeDigits = "+243";
  bool isVisible = true;
  bool isCreation = true;
  final MesPiecesBloc _bloc = MesPiecesBloc();
  String dateOfBirth = '';

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController country = TextEditingController();

  _onSubmit() {
    if (!_key.currentState!.validate()) return;
    _bloc.add(RegisterUser(
      email: email.text.trim(),
      password: password.text.trim(),
      userModel: UserModel(
        email: email.text.trim(),
        country: country.text,
        referenceCode: 'ADMIN001',
        lastName: name.text.trim(),
        dateOfBirth: dateOfBirth,
        profileImgUrl: '',
        phone: dialCodeDigits! + phone.text.trim(),
      ),
    ));
    AppPrefs.prefs!.setString('name', name.text.trim());
  }

  _clearFields() {
    name.clear();
    email.clear();
    phone.clear();
    password.clear();
    confirmPassword.clear();
    country.clear();
  }

  _sendEmailMethod (){
    _bloc.add(SendEmailVerificationEvent());
  }


  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UserCreated) {
          _sendEmailMethod();
          Navigator.pushNamedAndRemoveUntil(context, EmailVerificationScreen.routeName, (route) => false);
          successToast(
              message: 'Vous êtes enregistrée, verifions votre adresse mail');
          _clearFields();
        } else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 25,
                ),
                AuthHeaderWithArrow(
                    text: 'Complétez des informations sur vous'),
                SizedBox(
                  height: 10,
                ),
                AuthLabel('Prénom'),
                userNameField(
                  controller: name,
                ),
                AuthLabel('Année de naissance'),
                SizedBox(
                  height: 50,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(bottom: 10, right: 10, left: 10),
                      ),
                      items: ListHelper.years.map((items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Text(items, style: TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          dateOfBirth = val!;
                        });
                      }),
                ),
                AuthLabel('Pays'),
                countryField(
                  controller: country,
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        onSelect: (selectedCountry) {
                          setState(() {
                            country.text = selectedCountry.name;
                          });
                        });
                  },
                ),
                AuthLabel('Email'),
                emailField(
                  controller: email,
                ),
                AuthLabel('Télephone'),
                phoneNumberField(
                  controller: phone,
                  prefixIcon: CountryCodePicker(
                    onChanged: (country) {
                      setState(() => dialCodeDigits = country.dialCode);
                    },
                    initialSelection: "CD",
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: false,
                    favorite: ["+256", "UG", "+243", "CD"],
                  ),
                ),
                AuthLabel('Mot de passe'),
                passwordField(
                    controller: password,
                    obscureText: isVisible ? true : false,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? Icon(
                              Icons.remove_red_eye_rounded,
                              color: Color(0xff004d99),
                              size: 20,
                            )
                          : Icon(
                              Icons.visibility_off_rounded,
                              color: Color(0xff004d99),
                              size: 20,
                            ),
                    )),
                AuthLabel('Confirmer le mot de passe'),
                confirmPasswordField(
                  controller: confirmPassword,
                  obscureText: isVisible ? true : false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ce champ ne peut pas etre vide";
                    } else if (value.toString() != password.text.trim()) {
                      return "Les mots de passe ne sont pas identiques";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: isVisible
                        ? Icon(
                            Icons.remove_red_eye_rounded,
                            color: Color(0xff004d99),
                            size: 20,
                          )
                        : Icon(
                            Icons.visibility_off_rounded,
                            color: Color(0xff004d99),
                            size: 20,
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<MesPiecesBloc, MesPiecesState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is LoadingState ? () {} : _onSubmit,
                      text: state is LoadingState
                          ? 'Patientez...'
                          : 'Créer un compte',
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Avez-vous dejà un compte?'),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text(
                            'Se connecter',
                            style: TextStyle(color: primary, fontWeight: bold),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
