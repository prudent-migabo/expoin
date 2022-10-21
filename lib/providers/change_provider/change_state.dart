import 'package:expoin/models/models.dart';

enum ChangeStatus{
  initial,
  isLoading,
  isLoaded,
  error,
}

class ChangeState{
  ChangeStatus changeStatus;
  CustomError? error;

  ChangeState({
    required this.changeStatus,
    this.error,
  });

  ChangeState copyWith({
    ChangeStatus? changeStatus,
    CustomError? error,
  }) {
    return ChangeState(
      changeStatus: changeStatus ?? this.changeStatus,
      error: error ?? this.error,
    );
  }

  factory ChangeState.init(){
    return ChangeState(changeStatus: ChangeStatus.initial);
  }

}