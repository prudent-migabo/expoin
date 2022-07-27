import 'package:expoin/providers/crypto_to_mobile_provider/crypto_to_mobile_state.dart';
import 'package:expoin/screens/crypto_to_mobile_screen/transaction/components/components.dart';
import 'package:expoin/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptoToMobileScreen extends StatelessWidget {
  const CryptoToMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kMainColor,
      body: CryptoToMobileComponents(),
    );
  }
}
