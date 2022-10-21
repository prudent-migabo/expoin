import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/providers/register_provider/register_state.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterComponents extends StatefulWidget {

  RegisterComponents({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterComponents> createState() => _RegisterComponentsState();
}

class _RegisterComponentsState extends State<RegisterComponents> {

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }

  double? width;
  double? height;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _key1 = GlobalKey<FormFieldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _referenceCodeController = TextEditingController();
  bool isVisible = false;
  bool isConfirmVisible = false;
  String? _countryValue;

  @override
  Widget build(BuildContext context) {
    var registerState = context.watch<RegisterProvider>().state;
    return Form(
     key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100,),
          Text("Expoin", style: TextStyle(color: kMainColor, fontSize: 40, fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text("S'inscrire", style: TextStyle(color: kMainColor, fontSize: 25, fontWeight: FontWeight.bold),),
          SizedBox(height: 17,),
          Text("Créer votre compte d'utilisation...", style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          TextFormField(
            controller: _firstNameController,
            decoration: textFieldLoginDecoration(
                prefixIcon: Icons.person,
                hintText: "Prénom",
              labelText: "Prénom",
            ),
            validator:  (value) => value!.isEmpty? "Ce champ ne peut pas être vide" : null,
            onChanged: (value) => _firstNameController.text,
          ),
          SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
           controller: _emailController,
            decoration: textFieldLoginDecoration(
                prefixIcon: Icons.mail_rounded,
                hintText: "Email",
              labelText: "Email",
            ),
            validator:  (value){
              if(value!.isEmpty){
                return "Ce champ ne peut être vide";
              }else if (!value.contains("@")){
                return "Email mal composé";
              }
            },
           onChanged: (val) => _emailController.text,
          ),
          SizedBox(height: 20,),
          TextFormField(
           controller: _passwordController,
           obscureText: isVisible ? false : true,
           decoration: textFieldLoginDecoration(
               prefixIcon: Icons.vpn_key_rounded,
             suffixIcon: IconButton(
               onPressed: (){
                 setState(() {
                   isVisible = !isVisible;
                 });
               },
               icon: isVisible? Icon(Icons.visibility_off_rounded, color: Color(0xff004d99), size: 20,) : Icon(Icons.remove_red_eye_rounded, color: Color(0xff004d99), size: 20,),
             ),
               labelText: "Mot de passe",
               hintText: "Mot de passe"),
            validator: (value){
              if(value!.isEmpty){
                return "Ce champ ne peut être vide";
              } else if(value.length < 6) {
                return "Mot de passe trop court";
              }
            },
           onChanged: (val)=> _passwordController.text,
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: isConfirmVisible ? false : true,
            decoration: textFieldLoginDecoration(
              prefixIcon: Icons.vpn_key_rounded,
              hintText: "Confirmez le mot de passe",
              labelText: "Confirmez le mot de passe",
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    isConfirmVisible = !isConfirmVisible;
                  });
                },
                icon: isConfirmVisible? Icon(Icons.visibility_off_rounded, color: Color(0xff004d99), size: 20,) : Icon(Icons.remove_red_eye_rounded, color: Color(0xff004d99), size: 20,),
              ),
            ),
            validator:  (value) {
              if(value!.isEmpty){
                return "Ce champ ne peut pas être vide";
              } else if (_passwordController.text != _confirmPasswordController.text){
                return "Les deux mots de passe ne sont pas identiques";
              }
            },
            onChanged: (value) => _confirmPasswordController.text,
          ),
          SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            decoration: textFieldLoginDecoration(prefixIcon:Icons.phone, hintText: "Téléphone", labelText: "Téléphone"),
            validator:  (value) => value!.isEmpty? "Ce champ ne peut pas être vide" : null,
            onChanged: (value) => _phoneNumberController.text,
          ),
          SizedBox(height: 20,),
          DropdownButtonFormField(
            key: _key1,
            value: _countryValue,
            decoration: textFieldLoginDecoration(
              prefixIcon: Icons.location_city,
              hintText: 'Pays',
            ),
            items: ListHelper().listOfCountries.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                _countryValue = value.toString();
              });
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: _referenceCodeController,
            decoration: textFieldLoginDecoration(
                prefixIcon: Icons.keyboard_alt_outlined,
                hintText: "Code de reférence",
              labelText: "Code de reférence"
            ),
            // validator:  (value) => value!.isEmpty? "Ce champ ne peut pas être vide" : null,
            // onChanged: (value) => _referenceCodeController.text,
          ),
          SizedBox(height: 30,),
          CustomButton(
            text: registerState.registerStatus == RegisterStatus.isLoading? "PATIENTEZ...":"S'INSCRIRE",
            onPressed: registerState.registerStatus == RegisterStatus.isLoading?(){}:() async{
              if(!_formKey.currentState!.validate()) return;
              try{
                await context.read<RegisterProvider>().createUser(email: _emailController.text,password: _passwordController.text,
                    userModel: UserModel(
                 confirmPassword: _confirmPasswordController.text,
                 country: _countryValue,
                 firstName: _firstNameController.text,
                 phoneNumber: _phoneNumberController.text,
               ));
              } on CustomError catch (e){
                return errorDialog(context, e);
              }
            },
          ),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text("Avez-vous deja un compte?", style: TextStyle(color: Colors.black, fontSize: 13),),
                  ),
                  TextButton(onPressed: (){
                    context.read<LoginProvider>().initialState();
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }, child: Text("Se connecter", style: TextStyle(color: kMainColor),)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
