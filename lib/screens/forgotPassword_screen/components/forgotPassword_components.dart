import 'package:expoin/models/models.dart';
import 'package:expoin/providers/forgot_password_provider/forgot_password_state.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/utils/utils.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordComponents extends StatefulWidget {
   ForgotPasswordComponents({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordComponents> createState() => _ForgotPasswordComponentsState();
}

class _ForgotPasswordComponentsState extends State<ForgotPasswordComponents> {
   final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var forgotState = context.watch<ForgotPasswordProvider>().state;
    if(forgotState.forgotPasswordStatus == ForgotPasswordStatus.isLoaded){
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
      });
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Icon(Icons.vpn_key_outlined, size: 100,),
              SizedBox(height: 10,),
              Text("Mot de passe oublié", textAlign: TextAlign.center, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              Text("Saisissez votre adresse mail afin de recevoir le nouveau mot de passe", textAlign: TextAlign.center,),
              SizedBox(height: 60,),
              TextFormField(
                controller: _emailController,
                decoration: textFieldLoginDecoration(
                  hintText: "Votre adresse mail",
                ),
                validator: (value) => value!.isEmpty || !value.contains("@")? "Email incorrecte": null,
                onChanged: (val)=> _emailController.text,
              ),
              SizedBox(height: 15,),
              CustomButton(
                text: forgotState.forgotPasswordStatus == ForgotPasswordStatus.isLoading?"PATIENTEZ...":"CONTINUER",
                onPressed: forgotState.forgotPasswordStatus == ForgotPasswordStatus.isLoading? (){}: _onReceiveEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }

   Future<void> _onReceiveEmail()async{
     try{
       if(!_formKey.currentState!.validate())return;
       await context.read<ForgotPasswordProvider>().resetPassword(email: _emailController.text);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('email sent')));
     }on CustomError catch(e){
       errorDialog(context, e);
     }
   }
}
