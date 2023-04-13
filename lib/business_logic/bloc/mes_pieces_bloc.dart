import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expoin/business_logic/bloc/mes_pieces_state.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

////===== THIS IS THE MAIN EVENT CLASS MANAGER, EVERY EVENT OF THE APP MUST EXTEND THIS CLASS TO BE USED AS A BLOC EVENT ====////
abstract class MesPiecesEvent {
Stream<MesPiecesState> applyAsync({
  MesPiecesBloc bloc,
  MesPiecesState currentState,
});
}

////===== THIS IS THE MAIN STATE CLASS MANAGER, EVERY STATE EMITTED IN THE APP MUST EXTEND THIS CLASS TO BE USED AS A BLOC STATE ====////
abstract class MesPiecesState extends Equatable {
  int? index;
   MesPiecesState({this.index});

  @override
  List<Object> get props => [];
}

/* ////// ************* THIS IS THE BLOC WHICH MANAGES ALL BLOCS OF THE APP BY CREATING ONE EVENT AT TIME, WITH THIS METHOD WE DON'T NEED
TO PROVIDE THE BLOC EACH BLOC SEPARATELY TO THE WIDGET TREE IN ORDER TO USE IT WE CAN JUST SIMPLY CREATE AN INSTANCE OF THIS BLOC EVERY WHERE
WE NEED IT IN WHOLE THE APP ************** */

class MesPiecesBloc extends Bloc<MesPiecesEvent, MesPiecesState> {
  MesPiecesBloc() : super (InitialState()){
    //This is a new syntax which came with the updated bloc version (version 8.1), in remplacement of MapEventToState syntax but kept the same goal
    on<MesPiecesEvent> ((event, emit) async{
      try{
        emit(LoadingState());
        String networkStatus = await isConnected();
        if (networkStatus == "connected"){
         return emit.forEach(
            event.applyAsync(bloc: this, currentState: state).cast<MesPiecesState>(),
            onData: (MesPiecesState state) => state,
          );
        }  else{
          emit (NoNetworkState());
        }
      } catch (e){
        emit(ErrorState(
          message: e.toString(),
        ));
      }
    }, transformer: sequential());
  }
  static String pinCode = '';
  static String selectedCryptoName = 'Selectionnez';
  static String selectedBoutiqueID = '';
  static String boutiqueID = '';
  static String selectedBoutiqueName = '';
  static Map boutiquesInfo = {};
  static String selectedBoutiquePhone = '';
}

