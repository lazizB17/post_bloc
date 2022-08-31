part of 'update_bloc.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();
}

class UpdateInitialState extends UpdateState {
  final bool isLoading;

  @override
  List<Object> get props => [];

  const UpdateInitialState(this.isLoading);
}

class UpdateSuccessState extends UpdateState {
  final String successMSG;

  @override
  List<Object?> get props => throw UnimplementedError();

  const UpdateSuccessState(this.successMSG);
}

class UpdateErrorState extends UpdateState {
  final String errorMSG;

  @override
  List<Object?> get props => [errorMSG];

  const UpdateErrorState(this.errorMSG);
}
