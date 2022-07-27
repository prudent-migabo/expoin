import 'package:expoin/screens/crypto_to_crypto_screen/transaction/components/components.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class CryptoToCryptoScreen extends StatelessWidget {
  CryptoToCryptoScreen({Key? key}) : super(key: key);
  String? cryptoCategory;

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: CryptoToCryptoComponents(),
    );
  }
}
