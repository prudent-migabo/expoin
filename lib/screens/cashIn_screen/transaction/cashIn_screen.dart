import 'package:expoin/screens/cashIn_screen/transaction/components/components.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CahInScreen extends StatelessWidget {
  const CahInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainWhiteColor,
      body: CashInComponents()
    );
  }
}
