import 'package:expoin/models/models.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HashNumberProvider with ChangeNotifier{
  String hashBAND = 'BAND PROTOL (BAND)';
  String hashBTC = 'BITCOIN (BTC)';
  String hashADA = 'CARDANO (ADA)';
  String hashATOM = 'COSMOS (ATOM)';
  String hashDOGE = 'DOGECOIN (DOGE)';
  String hashETH = 'ETHERIUM (ETH)';
  String hashETC = 'ETHERIUM CLASSIC (ETC)';
  String hashICX = 'ICON (ICX)';
  String hashKMD = 'KOMODO (KMD)';
  String hashSOL = 'SOLANA (SOL)';
  String hashBNB = 'SMART CHAIN (BNB)';
  String hashLUNA = 'TERA (LUNA)';
  String hashXRZ = 'TEZOS (XRZ)';
  String hashTRX = 'TRON (TRX)';
  String hashTether = 'USDT_TRC20 (Tether)';
  String hashUSDT_ERC20 = 'USDT_ERC20';
  String hashUSDC_TRX = 'USDC_TRX';
  String hashUSDC_ETH = 'USDC_ETH';
  String hashZIL = 'ZILLIQA (ZIL)';
  String hashINU = 'SHIBA INU';

  Stream<HashNumberModel>? getHash(BuildContext context, String newCryptoType, ){

    if(newCryptoType == hashBAND){
      return context.watch<HashNumberRepository>().getHashNumber(hashBAND);
    }
    else if (newCryptoType == hashBTC){
      return context.watch<HashNumberRepository>().getHashNumber(hashBTC);
    }
    else if (newCryptoType == hashADA){
      return context.watch<HashNumberRepository>().getHashNumber(hashADA);
    }
    else if (newCryptoType == hashATOM){
      return context.watch<HashNumberRepository>().getHashNumber(hashATOM);
    }
    else if (newCryptoType == hashDOGE){
      return context.watch<HashNumberRepository>().getHashNumber(hashDOGE);
    }
    else if (newCryptoType == hashETH){
      return context.watch<HashNumberRepository>().getHashNumber(hashETH);
    }
    else if (newCryptoType == hashETC){
      return context.watch<HashNumberRepository>().getHashNumber(hashETC);
    }
    else if (newCryptoType == hashICX){
      return context.watch<HashNumberRepository>().getHashNumber(hashICX);
    }
    else if (newCryptoType == hashKMD){
      return context.watch<HashNumberRepository>().getHashNumber(hashKMD);
    }
    else if (newCryptoType == hashSOL){
      return context.watch<HashNumberRepository>().getHashNumber(hashSOL);
    }
    else if (newCryptoType == hashBNB){
      return context.watch<HashNumberRepository>().getHashNumber(hashBNB);
    }
    else if (newCryptoType == hashLUNA){
      return context.watch<HashNumberRepository>().getHashNumber(hashLUNA);
    }
    else if (newCryptoType == hashXRZ){
      return context.watch<HashNumberRepository>().getHashNumber(hashXRZ);
    }
    else if (newCryptoType == hashTRX){
      return context.watch<HashNumberRepository>().getHashNumber(hashTRX);
    }
    else if (newCryptoType == hashTether){
      return context.watch<HashNumberRepository>().getHashNumber(hashTether);
    }
    else if (newCryptoType == hashUSDT_ERC20){
      return context.watch<HashNumberRepository>().getHashNumber(hashUSDT_ERC20);
    }
    else if (newCryptoType == hashUSDC_TRX){
      return context.watch<HashNumberRepository>().getHashNumber(hashUSDC_TRX);
    }
    else if (newCryptoType == hashUSDC_ETH){
      return context.watch<HashNumberRepository>().getHashNumber(hashUSDC_ETH);
    }
    else if (newCryptoType == hashZIL){
      return context.watch<HashNumberRepository>().getHashNumber(hashZIL);
    }
    else if (newCryptoType == hashINU){
      return context.watch<HashNumberRepository>().getHashNumber(hashINU);
    }

    return null;
  }

  String cryptoType = '';
  void saveCryptoType (String newCryptoType){
    cryptoType = newCryptoType;
    notifyListeners();
  }
}