import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/presentation/screens/account_details_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';

class AccountDetailsScreen extends StatefulWidget {
  AccountDetailsScreen({Key? key, this.cryptoName}) : super(key: key);

  String? cryptoName;

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();
  final MesPiecesBloc _bloc = MesPiecesBloc();

  _onSubmit(){
    if(!_formKey.currentState!.validate()) return;
    _bloc.add(UpdateWalletEvent(newWalletAddress: _controller.text.trim(), cryptoName: widget.cryptoName!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CryptoUpdated) {
          successToast(message: 'Adresse mise à jour avec succès');
          _controller.clear();
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back_ios_new, size: 20,)),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text("Modifier l'adresse pour ${widget.cryptoName}",
                      style: TextStyle(fontSize: 19, fontWeight: bold),),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: CustomCardCryptoModel(
                  controller: _controller,
                  image: cryptoImageSelector(widget.cryptoName!),
                  title: widget.cryptoName,
                ),
              ),
              SizedBox(height: 10,),
              BlocBuilder<MesPiecesBloc, MesPiecesState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: CustomButton(
                      text: state is LoadingState
                          ? 'Patientez...'
                          : 'Mettre à jour',
                      onPressed: state is LoadingState ? () {} : _onSubmit,
                    ),
                  );
                },
              ),
              SizedBox(height: 30,),
              CurrentWalletText(cryptoName: widget.cryptoName!),
            ],
          ),
        ),
      ),
    );
  }
}
