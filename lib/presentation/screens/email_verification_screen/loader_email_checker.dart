import 'dart:async';

import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';

class LoaderEmailChecker extends StatefulWidget {
  LoaderEmailChecker({Key? key}) : super(key: key);

  @override
  State<LoaderEmailChecker> createState() =>
      _LoaderEmailCheckerState();
}

class _LoaderEmailCheckerState extends State<LoaderEmailChecker> {
  final MesPiecesBloc _bloc = MesPiecesBloc();
  Timer? timer;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      _bloc.add(
        InitialVerificationEvent(),
      );
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is IsEmailVerified){
          Navigator.pushNamedAndRemoveUntil(context, PinVerificationScreen.routeName, (route) => false);
          timer!.cancel();
        }else if (state is IsNotEmailVerified){
          Navigator.pushNamedAndRemoveUntil(context, EmailVerificationScreen.routeName, (route) => false);
        }  else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}