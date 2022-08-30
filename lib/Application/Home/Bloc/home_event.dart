part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomePostGetEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeDeleteEvent extends HomeEvent{
  int id;

  @override
  List<Object?> get props => [];

  HomeDeleteEvent({required this.id});
}

