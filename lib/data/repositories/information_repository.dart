import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/business_logic/bloc/mes_pieces_bloc.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/models/models.dart';
import 'package:expoin/utils/utils.dart';

class InformationRepository {
  FirebaseFirestore ref = FirebaseFirestore.instance;
  FirebaseAuth? auth = FirebaseAuth.instance;
  CollectionReference boutiqueRef =
      FirebaseFirestore.instance.collection('boutique');
  String cryptoWallet = 'cryptoWallet';
  String mobileMoneyWallet = 'mobileMoneyWallet';
  String bankWallet = 'bankWallet';
  String userPin = 'userPin';

  ////============== METHODS FOR CRUD OPERATIONS FOR CRYPTO INFORMATION FROM FIRESTORE =================//////
  Future registerWalletAddress(
      {Map<String, dynamic>? data, String? cryptoName}) async {
    await userRef
        .doc(auth!.currentUser!.uid)
        .collection(cryptoWallet)
        .doc(cryptoName)
        .set(data!);
  }

  List<WalletAddressModel> listWalletAddressModel(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((e) => WalletAddressModel.fromMap(e))
        .toList();
  }

  Stream<List<WalletAddressModel>> getListWalletAddressModel() {
    return userRef
        .doc(auth!.currentUser!.uid)
        .collection(cryptoWallet)
        .where('uid', isEqualTo: auth!.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(listWalletAddressModel);
  }

  Future updateWalletAddress(
      {String? newWalletAddress, String? cryptoName}) async {
    await userRef
        .doc(auth!.currentUser!.uid)
        .collection(cryptoWallet)
        .doc(cryptoName)
        .update({'walletAddress': newWalletAddress});
  }

  Future deleteCrypto(String docID) async {
    await userRef
        .doc(auth!.currentUser!.uid)
        .collection(cryptoWallet)
        .doc(docID)
        .delete();
  }

  Stream<WalletAddressModel> getWalletAddress(String cryptoName) {
    return userRef
        .doc(auth!.currentUser!.uid)
        .collection(cryptoWallet)
        .doc(cryptoName)
        .snapshots()
        .map((doc) => WalletAddressModel.fromMap(doc));
  }

  /////============== METHOD THAT STORES AND RETRIEVES USER'S PIN CODE IN FIRESTORE =========//////
  Future savePin({Map<String, dynamic>? data}) async {
    await userRef
        .doc(auth!.currentUser!.uid)
        .collection(userPin)
        .doc(auth!.currentUser!.uid)
        .set(data!);
  }

  Future updatePin(String newPinCode) async {
    await userRef
        .doc(auth!.currentUser!.uid)
        .collection(userPin)
        .doc(auth!.currentUser!.uid)
        .update({'pinCode': newPinCode});
  }

  ///////============= METHODE THAT RETRIEVES PIN CODE FROM FIRESTORE AND STORES IT IN SHARED PREFERENCES ===================///////////
  Future getPinCode() async {
    DocumentSnapshot fetchData = await userRef
        .doc(auth!.currentUser!.uid)
        .collection(userPin)
        .doc(auth!.currentUser!.uid)
        .get();
    if (fetchData.exists) {
      Map data = fetchData.data()! as Map;
      MesPiecesBloc.pinCode = data['pinCode'];
    }
  }

  Stream<PinModel> getPin() {
    return userRef
        .doc(auth!.currentUser!.uid)
        .collection(userPin)
        .doc(auth!.currentUser!.uid)
        .snapshots()
        .map((event) => PinModel.fromMap(event));
  }

  ///// ============ METHOD THAT RETRIEVES THE BOUTIQUE DETAILS FROM FIRESTORE =============///////
  List<BoutiqueModel> listBoutiques(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) => BoutiqueModel.fromMap(e)).toList();
  }

  Stream<List<BoutiqueModel>> getListBoutique() {
    return boutiqueRef.orderBy('createdAt', descending: true).snapshots().map(listBoutiques);
  }

  //////============ METHOD THAT RETRIEVES THE ACTIVES CRYPTOS IN FIRESTORE =========/////////
  List<CryptoModel> listCryptoModel(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) => CryptoModel.fromMap(e)).toList();
  }

  Stream<List<CryptoModel>> getListOfActivesCrypto(String boutiqueID) {
    return boutiqueRef
        .doc(boutiqueID)
        .collection(cryptoWallet)
        .where('uid', isEqualTo: boutiqueID)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(listCryptoModel);
  }

  ///////========= METHOD THAT RETRIEVES BOUTIQUES DEPENDING ON A SPECIFIC CRYPTO NAME ==============///////
  Stream<List<BoutiqueModel>> getListOfFilteredBoutiques(
      {String? boutiqueID, String? cryptoName}) {
    return boutiqueRef
        .doc(boutiqueID)
        .collection(cryptoWallet)
        .where('name', isEqualTo: cryptoName)
        .where('isActive', isEqualTo: true)
        .where('isDeleted' , isEqualTo: false)
        .where('isBlocked', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(listBoutiques);
  }

  Stream<BoutiqueModel> getListOfFilteredBoutiquesByName(
      {String? boutiqueID, String? cryptoName}) {
    return boutiqueRef
        .doc(boutiqueID)
        .snapshots()
        .map((event) => BoutiqueModel.fromMap(event));
  }

}
