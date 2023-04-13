import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/screens/account_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';

import '../../presentation.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final MesPiecesBloc _bloc = MesPiecesBloc();
  final _formKey = GlobalKey<FormState>();
  String selectedValue = ListHelper.cryptosCategories[0];
  final TextEditingController _walletAddress = TextEditingController();


  _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    _bloc.add(RegisterWalletEvent(
      cryptoName: selectedValue,
      cryptoModel: WalletAddressModel(
        name: selectedValue,
        walletAddress: _walletAddress.text.trim(),
      ),

    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
  listener: (context, state) {
    if (state is CryptosCreated) {
      successToast(message: 'Wallet sauvegardé avec succes');
      _walletAddress.clear();
    } else if (state is ErrorState) {
      errorDialog(context, content: state.message);
    } else if (state is NoNetworkState) {
      noNetworkToast(context);
    }
  },
  child: Scaffold(
      body: SingleChildScrollView(
        padding: mainPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text('Comptes', style: TextStyle(fontSize: 23, fontWeight: bold),),
            SizedBox(height: 10,),
            ListCryptoWallets(),
            SizedBox(height: 50,),
            Text('+ Ajouter une address', style: TextStyle(fontWeight: bold, fontSize: 15),),
            SizedBox(height: 15,),
            DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'Selectionnez un crypto de votre choix',
                  hintStyle: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                items: ListHelper.cryptosCategories.map((item)
                => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: GoogleFonts.dmSans(fontSize: 13),))).toList(),
                onChanged: (value){
                  setState(() {
                    selectedValue = value!.toString();
                  });
                }
            ),
            Form(
              key: _formKey,
              child: CustomCardCryptoModel(
                controller: _walletAddress,
                image: cryptoImageSelector(selectedValue),
                title: selectedValue,
              ),
            ),
            BlocBuilder<MesPiecesBloc, MesPiecesState>(
              bloc: _bloc,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: CustomButton(
                    text: state is LoadingState
                        ? 'Patientez...'
                        : 'Enregistrer',
                    onPressed: state is LoadingState ? () {} : _onSubmit,
                  ),
                );
              },
            ),
          ],
        ),
        ),
      ),
);
  }
}
