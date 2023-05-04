import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expoin/utils/utils.dart';

Widget userNameField({
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    validator: (val) => val!.isEmpty ? "Ce champ ne peut pas etre vide" : null,
  );
}

Widget referenceCode({
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    validator: (val) => val!.isEmpty ? "Ce champ ne peut pas etre vide" : null,
  );
}

Widget countryField({
  TextEditingController? controller,
  VoidCallback? onTap,
  Function(String? value)? validator,
}) {
  return InkWell(
    onTap: onTap,
    child: TextFormField(
      enabled: false,
      controller: controller,
      validator: (val) =>
          val!.isEmpty ? "Ce champ ne peut pas etre vide" : null,
    ),
  );
}

Widget emailField({
  TextEditingController? controller,
}) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return "Ce champ ne peut être vide";
      } else if (!value.contains("@")) {
        return "Email mal composé";
      }
    },
  );
}

Widget phoneNumberField({
  TextEditingController? controller,
  Widget? prefixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.phone,
    validator: (value) => value!.isEmpty
        ? 'Une value null ne peut être enregistrée'
        : value.length < 8 ? "Numéro trop court, il doit etre d'au moins 8 chiffres"
        : value.length > 9 ? "Numéro trop long, il doit etre d'au plus 9 chiffres"
        : null,
    decoration: textFieldAuthDecoration(
      prefixIcon: prefixIcon,
    ),
  );
}

Widget passwordField(
    {TextEditingController? controller,
    bool? obscureText,
    Widget? suffixIcon}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText!,
    decoration: textFieldAuthDecoration(
      suffixIcon: suffixIcon,
    ),
    validator: (val) {
      if (val!.isEmpty) {
        return "Ce champ ne peut être vide";
      } else if (val.length < 6) {
        return "Mot de passe trop court";
      }
    },
  );
}

Widget confirmPasswordField(
    {TextEditingController? controller,
    bool? obscureText,
    Widget? suffixIcon,
    String? Function(String? value)? validator}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText!,
    decoration: textFieldAuthDecoration(
      suffixIcon: suffixIcon,
    ),
    validator: validator,
  );
}
