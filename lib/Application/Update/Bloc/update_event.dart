part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();
}

class UpdatePostEvent extends UpdateEvent{
  final Post post;

  const UpdatePostEvent(this.post);

  @override
  List<Object?> get props =>[];
}
