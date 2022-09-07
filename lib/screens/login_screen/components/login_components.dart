import 'package:expoin/models/models.dart';
import 'package:expoin/providers/login_provider/login_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginComponents extends StatefulWidget {
  LoginComponents({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginComponents> createState() => _LoginComponentsState();
}

class _LoginComponentsState extends State<LoginComponents> {
  double? width;
  double? height;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var loginState = context.watch<LoginProvider>().state;
    if(loginState.loginStatus == LoginStatus.isLoaded){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(context, BottomNavigationScreen.routeName, (route) => false);
      });
    }
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100,),
                Text("Expoin", style: TextStyle(color: kMainColor, fontSize: 40, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Se Connecter", style: TextStyle(color: kMainColor, fontSize: 25, fontWeight: FontWeight.bold),),
                SizedBox(height: 17,),
                Text("Connectez-vous pour gérer votre compte...", style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                TextFormField(
                  controller: _emailController,
                  validator:  (value){
                    if(value!.isEmpty){
                      return "Ce champ ne peut être vide";
                    }else if (!value.contains("@")){
                      return "Email mal composé";
                    }
                  },
                  decoration: textFieldLoginDecoration(prefixIcon: Icon(Icons.mail_rounded, color: Color(0xff004d99), size: 20,), hintText: "Email"),
                  onChanged: (val) => _emailController.text,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isVisible? false : true,
                  decoration: textFieldLoginDecoration(
                      prefixIcon: Icon(Icons.vpn_key_rounded,color: Color(0xff004d99), size: 20,),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible? Icon(Icons.visibility_off_rounded, color: Color(0xff004d99), size: 20,) : Icon(Icons.remove_red_eye_rounded, color: Color(0xff004d99), size: 20,),
                      ),
                      hintText: "Mot de passe"),
                  validator: (val){
                    if(val!.isEmpty){
                      return "Ce champ ne peut être vide";
                    } else if(val.length < 6) {
                      return "Mot de passe trop court";
                    }
                  },
                  onChanged: (val) => _passwordController.text,
                ),
                SizedBox(height: 30,),
                CustomButton(
                  text: loginState.loginStatus == LoginStatus.isLoading?"PATIENTEZ...":"SE CONNECTER",
                  onPressed: loginState.loginStatus == LoginStatus.isLoading? (){}:() async{
                    if (!_formKey.currentState!.validate()) return;
                    try{
                      await context.read<LoginProvider>().signInUser(email: _emailController.text, password: _passwordController.text);
                    } on CustomError catch (e){
                     return errorDialog(context, e);
                    }
                  },
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 170),
                  child: GestureDetector(
                    onTap: () async{
                      await context.read<ForgotPasswordProvider>().initial();
                      Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                    },
                    child: Text("Mot de passe oublié?", style: TextStyle(color: kMainColor, fontSize: 13),),
                  ),
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
                          child: Text("Vous n'avez pas encore de compte?", style: TextStyle(color: Colors.black, fontSize: 13),),
                        ),
                        GestureDetector(
                          onTap: (){
                            context.read<RegisterProvider>().initialState();
                            Navigator.pushNamed(context, RegisterScreen.routeName);
                          },
                          child: Text("S'inscrire", style: TextStyle(color: kMainColor),),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
