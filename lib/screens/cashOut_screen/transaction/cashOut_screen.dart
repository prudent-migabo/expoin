import 'package:expoin/providers/crypto_to_mobile_provider/crypto_to_mobile_state.dart';
import 'package:expoin/screens/cashOut_screen/transaction/components/components.dart';
import 'package:expoin/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CashOutScreen extends StatelessWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kMainWhiteColor,
      body: CashOutComponents(),
    );
  }
}
