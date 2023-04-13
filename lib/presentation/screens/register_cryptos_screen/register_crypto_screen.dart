import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/data/repositories/repositories.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/presentation/screens/register_cryptos_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';

class RegisterCryptoScreen extends StatefulWidget {
  static const String routeName = '/RegisterCryptoScreen';

  const RegisterCryptoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCryptoScreen> createState() => _RegisterCryptoScreenState();
}

class _RegisterCryptoScreenState extends State<RegisterCryptoScreen> {

  final MesPiecesBloc _bloc = MesPiecesBloc();
  final _formKey = GlobalKey<FormState>();
  final InformationRepository _repository = InformationRepository();

  bool isCardSelected = false;
  final TextEditingController _walletAddress = TextEditingController();
  String selectedValue = ListHelper.cryptosCategories[0];
  String existingCryptoName = '';

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
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 15,
                ),
                AuthHeaderWithArrow(text: 'Configurez vos comptes de cryptomonaies'),
                SizedBox(
                  height: 20,
                ),
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
                        selectedValue = value.toString();
                      });
                    }
                ),
                SizedBox(height: 30,),
                Text(
                  "Configuration wallet",
                  style: TextStyle(fontWeight: bold, fontSize: 15),
                ),
                SizedBox(height: 15,),
                CardCryptoModel(
                  controller: _walletAddress,
                  image: cryptoImageSelector(selectedValue),
                  title: selectedValue,
                  // trailing: Container(),
                ),
                SizedBox(
                  height: 10,
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
                SizedBox(height: 40,),
                Text(
                  "Informations fournies",
                  style: TextStyle(fontWeight: bold, fontSize: 15),
                ),
                SizedBox(height: 15,),
                ListSelectedCrypto(cryptoType: selectedValue,),
                SizedBox(height: 25,),
                CustomButton(text: 'Sauvegarder et continuer', onPressed: (){
                  Navigator.pushNamed(context, BottomNavigationScreen.routeName);
                  successToast(message: 'Bienvenue');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//Icon(Icons.arrow_drop_down_circle_outlined)
