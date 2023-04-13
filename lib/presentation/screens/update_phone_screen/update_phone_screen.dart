import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class UpdatePhoneScreen extends StatefulWidget {
  static const String routeName = '/UpdatePhoneScreen';
   UpdatePhoneScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneScreen> createState() => _UpdatePhoneScreenState();
}

class _UpdatePhoneScreenState extends State<UpdatePhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final MesPiecesBloc _bloc = MesPiecesBloc();
  final TextEditingController _controller = TextEditingController();
  String? dialCodeDigits = "+243";
  final AuthRepository _repository = AuthRepository();

  _onSubmit(){
    if(!_formKey.currentState!.validate()) return;
    _bloc.add(UpdatePhoneEvent(newPhoneNumber: dialCodeDigits!+_controller.text.trim()));
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if(state is PhoneNumberUpdated){
          successToast(message: 'Numéro de téléphone modifié avec succès');
          _controller.clear();
        } else if (state is ErrorState){
          errorDialog(context, content: state.message);
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
                text: 'Changement du numéro de téléphone',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Actuel numéro de téléphone',
                style: TextStyle(fontWeight: bold, color: Colors.black54),
              ),
              SizedBox(height: 10,),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: StreamBuilder<UserModel>(
                    stream: _repository.getUserInformation(),
                    builder: (context, snapshot) {
                      UserModel? userModel = snapshot.data;
                      if(!snapshot.hasData){
                        return Text('+243*********',  style: TextStyle(fontWeight: bold),);
                      } else if (snapshot.hasError){
                        return Text('En attente...');
                      }
                      return Text(userModel!.phone!,  style: TextStyle(fontWeight: bold),);
                    }
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text(
                'Saisissez le nouveau mot de passe',
                style: TextStyle(fontWeight: bold, color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  validator: (val) => val!.isEmpty? "Ce champ ne peut pas etre vide" : val.length > 9 ? "Le numéro de téléphone ne doit pas depasser 9 chiffres" : null,
                  decoration: textFieldAuthDecoration(
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
