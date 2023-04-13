import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/data/data.dart';

class UpdateUserInfoEvent extends MesPiecesEvent{
  String profileImgUrl;
  String userName;

  UpdateUserInfoEvent({
    required this.profileImgUrl,
    required this.userName
  });

  @override
  Stream<MesPiecesState> applyAsync({MesPiecesBloc? bloc, MesPiecesState? currentState}) async*{

    ProfileRepository repository = ProfileRepository();

    try {
      await repository.updateUserInfo(profileImgUrl, userName);
      yield UserInformationUploaded();
    } catch (e){
      yield ErrorState(
        message: e.toString(),
      );
    }
  }

}