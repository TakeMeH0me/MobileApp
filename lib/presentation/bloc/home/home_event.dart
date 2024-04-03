part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class CreateHomeEvent extends HomeEvent {
  final HomeEntity home;

  const CreateHomeEvent({required this.home});

  @override
  List<Object> get props => [home];
}

final class GetAllHomesEvent extends HomeEvent {}

final class UpdateHomeEvent extends HomeEvent {
  final HomeEntity home;

  const UpdateHomeEvent({required this.home});

  @override
  List<Object> get props => [home];
}

final class DeleteHomeEvent extends HomeEvent {
  final String id;

  const DeleteHomeEvent({required this.id});

  @override
  List<Object> get props => [id];
}
