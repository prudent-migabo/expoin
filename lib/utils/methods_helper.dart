import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/utils/utils.dart';


Future<String> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return "connected";
  } else {
    return "Noconnexion";
  }
}

void errorToastsHelper (BuildContext context,  MesPiecesState state){
   if (state is ErrorState) {
  errorDialog(context, content: state.message);
  } else if (state is NoNetworkState) {
  noNetworkToast(context);
  }
}

String cryptoImageSelector (String value){
  switch (value) {
    case 'BAND PROTOL (BAND)':
      return Assets.bandProtocol;
    case 'BITCOIN (BTC)':
      return Assets.btcImage;
    case 'CARDANO (ADA)':
      return Assets.adaImage;
    case 'COSMOS (ATOM)':
      return Assets.cosmosAtomImage;
    case 'DOGECOIN (DOGE)':
      return Assets.dogecoinImage;
    case 'BUSDT' :
      return Assets.usdtImage;
    case 'ETHERIUM CLASSIC':
      return Assets.ethereumClassicImage;
    case 'ETHERIUM (ETH)' :
      return Assets.ethImage;
    case 'KOMODO (KMD)':
      return Assets.komodoImage;
    case 'SOLANA (SOL)':
      return Assets.solanaImage;
    case 'SMART CHAIN (BNB)':
      return Assets.bnbImage;
    case 'TERA (LUNA)':
      return Assets.teraImage;
    case 'TEZOS (XRZ)':
      return Assets.tezosImage;
    case 'TRON (TRX)':
      return Assets.tronTrxImage;
    case 'USDT_TRC20 (Tether)':
      return Assets.tetherImage;
    case 'USDT_ERC20':
      return Assets.usdtImage;
    case 'USDC_TRX':
      return Assets.bnbImage;
    case 'USDC_ETH':
      return Assets.usdtImage;
    case 'ZILLIQA (ZIL)':
      return Assets.zilligaImage;
    case 'SHIBA INU':
      return Assets.shibaInuImage;
    default:
      return '';
  }
}

String mobileImageSelector (String value){
  switch(value) {
    case "Airtel money (RDCongo)":
      return Assets.airtelLogo;
    case "Orange money (RDCongo)":
      return Assets.orangeLogo;
    case "M-Pesa (RDCongo)" :
      return Assets.mpesaLogo;
    case "Orange money (Mali)" :
      return Assets.orangeLogo;
    case "Moov money (Mali)" :
      return Assets.mooveMoney;
    case "Sama Money (Mali)" :
      return Assets.samaMoney;
    case "Wave (Mali)":
      return Assets.waveMoney;
    case "Mobil money (Côte d'Ivoire)":
      return Assets.mobilMoney;
    case "Moov money (Côte d'Ivoire)":
      return Assets.mooveMoney;
    case "MTN money(Côte d'Ivoire)":
      return Assets.mtnMoney;
    case "MOOVAFRICA (Benin)":
      return Assets.mooveMoney;
    case "Celtic (Benin)":
      return Assets.waveMoney;
    case "Orange money (Cameroun)":
      return Assets.orangeLogo;
    case "MTN money (Cameroun)":
      return Assets.mtnMoney;
    default:
      return '';
  }
}

final ImagePicker _picker = ImagePicker();

File? _image;
getImageFromGallery() async{
  XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    final temporaryImage = File(pickedImage.path);
    _image = temporaryImage;
    return _image;
  }
}