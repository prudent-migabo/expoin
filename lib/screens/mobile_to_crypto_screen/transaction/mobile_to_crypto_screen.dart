import 'package:expoin/screens/mobile_to_crypto_screen/transaction/components/components.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class MobileToCryptoScreen extends StatelessWidget {
  const MobileToCryptoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: MobileToCryptoComponents(),
    );
  }
}
