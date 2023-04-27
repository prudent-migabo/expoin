import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/presentation/screens/dashboard_screen/components/components.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardScreen extends StatefulWidget {
  static const String routeName = '/DashBoardScreen';

  DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final CashInRepository _repository = CashInRepository();
  final TotalAmountProvider _totalAmountProvider = TotalAmountProvider();
  final MesPiecesBloc _bloc = MesPiecesBloc();
  var a;

  final Uri whatsappUrl = Uri.parse("https://wa.me/message/X4KA5THVWWRMO1");

  Future<void> _launchUrl(Uri _url) async {
    try {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } catch (e) {
      errorDialog(context, content: "L'url $_url est introuvable");
    }
  }

  @override
  void initState() {
    context.read<TotalAmountProvider>().getCashInInfo();
    context.read<TotalAmountProvider>().getCashOutInfo();
    context.read<TotalAmountProvider>().getChangeInfo();
    //_totalAmountProvider.getCashInInfo();
    getInfo();
   // _bloc.add(GetCashInTotalEvent());
    super.initState();
  }

  Future getInfo() async {
    await for (List<CashInModel> list in _repository.getListCashInOrdered()) {
      for (CashInModel cashInModel in list) {
        setState(() {
          a = cashInModel.amountToSend;
        });
        // print ('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! $cashInAmountReceived');
      }
    }
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var val1 = context
        .watch<TotalAmountProvider>()
        .cashOutAmountReceived;
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        // if (state is ErrorState) {
        //   errorDialog(context, content: state.message);
        // } else if (state is NoNetworkState){
        //   noNetworkToast(context);
        // }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _launchUrl(whatsappUrl),
          backgroundColor: Colors.green,
          child: const Icon(
            FontAwesomeIcons.whatsapp,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              CarouselAdvertising(),
              Padding(
                padding: mainPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total depensé'),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<MesPiecesBloc, MesPiecesState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        if (state is GotCashInTotal) {
                          return Text(
                            '${state.cashInTotal}\$',
                            style: TextStyle(fontWeight: bold, fontSize: 20),
                          );
                        }
                        return Text(
                          '00\$',
                          style: TextStyle(fontWeight: bold, fontSize: 20),
                        );
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Boutiques',
                      style: TextStyle(fontWeight: bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // CustomCardField(controller: _searchController),
                    CustomAutoCompleteField(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomListCrypto(),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      'Boutiques',
                      style: TextStyle(fontWeight: bold),
                    ),
                    ListBoutiques(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
