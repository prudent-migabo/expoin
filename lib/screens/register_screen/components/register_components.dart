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
  double? width;
  double? height;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
           controller: _emailController,
            decoration: textFieldLoginDecoration(prefixIcon: Icon(Icons.mail_rounded, color: Color(0xff004d99), size: 20,), hintText: "Email"),
            validator:  (value){
              if(value!.isEmpty){
                return "Ce champ ne peut être vide";
              }else if (!value.contains("@")){
                return "Email mal composé";
              }
            },
           onChanged: (val) => _emailController.text,
          ),
          SizedBox(height: 15,),
          TextFormField(
           controller: _passwordController,
           decoration: textFieldLoginDecoration(prefixIcon: Icon(Icons.vpn_key_rounded,color: Color(0xff004d99), size: 20,), suffixIcon: Icon(Icons.remove_red_eye_rounded, color: Color(0xff004d99), size: 20,), hintText: "Mot de passe"),
            validator: (value){
              if(value!.isEmpty){
                return "Ce champ ne peut être vide";
              } else if(value.length < 6) {
                return "Mot de passe trop court";
              }
            },
           onChanged: (val)=> _passwordController.text,
          ),
          SizedBox(height: 30,),
          CustomButton(
            text: registerState.registerStatus == RegisterStatus.isLoading? "PATIENTEZ...":"S'INSCRIRE",
            onPressed: registerState.registerStatus == RegisterStatus.isLoading?(){}:() async{
              if(!_formKey.currentState!.validate()) return;
              try{
                print("========================");
              //FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString());
               await context.read<RegisterProvider>().createUser(email: _emailController.text.toString(),password: _passwordController.text.toString());
                print("${_emailController.text}, ${_passwordController.text}");
              } on CustomError catch (e){
                return errorDialog(context, e);
              }
            },
          ),
          SizedBox(height: 30,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text("Avez-vous deja un compte?", style: TextStyle(color: Colors.black, fontSize: 13),),
                  ),
                  GestureDetector(
                    onTap: (){
                      context.read<LoginProvider>().initialState();
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Text("Se connecter", style: TextStyle(color: kMainColor),),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
